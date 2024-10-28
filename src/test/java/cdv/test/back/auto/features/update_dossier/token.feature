Feature: Get Access Token from Oauth2 for rule engine

  Scenario:
    Given url  "https://rec.client.almerys.com/auth/realms/BCU_INT/protocol/openid-connect/token"
    And form field grant_type = 'password'
    And form field client_id = 'cdv-Back'
    And form field username = 'cbaudot'
    And form field password = 'Pdmdp2021!'
    And form field client_secret = '47db2336-eaf2-4a2a-8557-a3f9befb53e0'
    When method post
    Then status 200
    And def accessToken = response.access_token

