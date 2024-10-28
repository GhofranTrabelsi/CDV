function fn() {

  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property is:', env);

  if (!env) {
    env = 'dev';
  }
    if (env == 'devb') {
      var config = {
        "username": "cbaudot",
        "password": "Pdmdp2021!",
        "client_id": "prev-ds-back",
        "grant_type": "client_credentials",
        "client_secret": "e0ba3a7b-5b95-4dc4-a0d9-cf51806e2f13",
        "IAM_url": "https://rec.client.almerys.com/auth/realms/BCU_INT/protocol/openid-connect/token",
        "GexRT_url": "https://api-rcc.be-ys.com",
        "GexRT_ds_entrypoint": "ds/devb/v1"
      };
    }
    else if (env == 'dev') {
      var config = {
        "username": "cbaudot",
        "password": "Pdmdp2021!",
        "client_id": "prev-ds-back",
        "grant_type": "client_credentials",
        "client_secret": "e0ba3a7b-5b95-4dc4-a0d9-cf51806e2f13",
        "IAM_url": "https://rec.client.almerys.com/auth/realms/BCU_INT/protocol/openid-connect/token",
        "GexRT_url": "https://api-rcc.be-ys.com",
        "GexRT_ds_entrypoint": "ds/dev/v1"
      };
    }
    else if (env == 'demo') {
      var config = {
        "username": "cbaudot",
        "password": "Pdmdp2021!",
        "client_id": "desktop-Front",
        "grant_type": "password",
        "client_secret": "ffe19c9d-4b00-487e-80b5-700159e6ae57",
        "IAM_url": "https://rec.client.almerys.com/auth/realms/BCU_DEMO/protocol/openid-connect/token",
        "GexRT_url": "https://api-rcc.be-ys.com",
        "GexRT_ds_entrypoint": "ds/demo/v1"
      };
    }
    else if (env == 'recb') {
      var config = {
        "username": "cbaudot",
        "password": "Pdmdp2021!",
        "client_id": "prev-ds-back",
        "grant_type": "client_credentials",
        "client_secret": "578814ba-0015-435d-ab40-00a665bd1d5c",
        "IAM_url": "https://rec.client.almerys.com/auth/realms/BCU_DEMO/protocol/openid-connect/token",
        "GexRT_url": "https://api-rcc.be-ys.com",
        "GexRT_ds_entrypoint": "ds/recb/v1"
      };
      }
      karate.configure('connectTimeout', 20000);
      karate.configure('readTimeout', 20000);

      // Log pretty JSON
      karate.configure('logPrettyResponse', true);

      return config;
    }