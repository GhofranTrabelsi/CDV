Feature: Get
  Background:

    * table users
| username   | password    |
| 'cbaudot'  | 'Pdmdp2021!'|

* def signIn = call read('cdv/test/back/auto/features/update_ijss/token.feature') users
* def accessTokens = $signIn[*].accessToken
* configure ssl = true

  Scenario: Recover sinisters
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/occurrence/get-by-occurrence-id?occurrenceId=314bdb4a-2f24-452d-bec4-0f9a27701938&page=5'
    When method POST
    Then status 200
* def sinisters = response.sinisters

