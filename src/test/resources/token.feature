Feature: Get Access Token from Oauth2 for rule engine

  Scenario:
    Given url is 'https://rec.client.almerys.com/auth/realms/BCU_INT/protocol/openid-connect/token'
    And form field grant_type = 'password'
    And form field client_id = 'editique_back'
    And form field username = 'cbaudot'
    And form field password = 'Pdmdp2021!'
    And form field client_secret = 'a3e3fe3c-88f0-4318-a30f-b4030dff8a95'
    When method post
    Then status 200
    And def accessToken = response.access_token

