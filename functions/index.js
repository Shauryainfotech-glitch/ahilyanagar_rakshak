const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendSOSToPolice = functions.database
  .ref('/sos_alerts/{alertId}')
  .onCreate(async (snapshot, context) => {
    const sosData = snapshot.val();
    if (!sosData) return null;

    // Query all users with role 'police'
    const usersSnap = await admin.database().ref('/users').orderByChild('role').equalTo('police').once('value');
    const tokens = [];
    usersSnap.forEach(child => {
      const user = child.val();
      if (user.fcmToken) {
        tokens.push(user.fcmToken);
      }
    });

    if (tokens.length === 0) {
      console.log('No police FCM tokens found.');
      return null;
    }

    // Compose notification
    const payload = {
      notification: {
        title: 'Emergency SOS Alert',
        body: 'A citizen has triggered an SOS! Tap to view location.',
      },
      data: {
        type: 'sos',
        latitude: String(sosData.location?.latitude || ''),
        longitude: String(sosData.location?.longitude || ''),
      },
    };

    // Send notification to all police tokens
    const response = await admin.messaging().sendToDevice(tokens, payload);
    console.log('SOS notification sent to police:', response.successCount, 'successes');
    return null;
  }); 