Feature: update ijss
  Background:
  //  * def getSinisterId = call read('getsinistreId.js')

    * table users
      | username  | password     |
      | 'cbaudot' | 'Pdmdp2021!' |
    * configure ssl = true
    * def occurrenceId = '4158c4a1-28a8-4ae8-9b31-75fb7dba3c75'

  Scenario: update ijss
    * call read('token.feature')
    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/occurrence/get-by-occurrence-id?occurrenceId=' + occurrenceId + '&page=5'
    When method POST
    Then status 200
    * def sinisters = response.occurrences[0].sinisters
    * def sinistreId = response.occurrences[0].sinisters[0].id
    * print "sinistreId: " + sinistreId + " status: " + response.occurrences[0].sinisters[0].status
    * def getIndemnities = function(response) {     let indemnitiesArray = [];     let occurrences = response.occurrences;     for (let i = 0; i < occurrences.length; i++) {         let sinisters = occurrences[i].sinisters;         for (let j = 0; j < sinisters.length; j++) {             let benefits = sinisters[j].benefits;             for (let k = 0; k < benefits.length; k++) {                 let indemnities = benefits[k].indemnities;                 for (let l = 0; l < indemnities.length; l++) {                     if (indemnities[l].startDate != null) {                         indemnitiesArray.push(indemnities[l]);                     }                 }             }         }     }     return indemnitiesArray; }
    * def allIndemnities = getIndemnities(response)
    #* print allIndemnities

    ###################
    * def startDate = allIndemnities[0].startDate
    * print startDate
    * def convertToDate = function(iso) {var date = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX").parse(iso); var dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");return dateFormat.format(date);}
    * def formattedStartDate = convertToDate(startDate)
    * print 'Formatted start date:', formattedStartDate
    ###################
    * def endDate = allIndemnities[0].endDate
    #* print endDate
    * def formattedEndDate = convertToDate(endDate)
    * print 'Formatted end date:', formattedEndDate
    ###################
    * def parseDate = function(d) {         var sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");         return sdf.parse(d);     }
    * def dateDiff = function(date1, date2) {         var d1 = parseDate(date1);         var d2 = parseDate(date2);         var diff = d1.getTime() - d2.getTime();         return Math.abs(Math.round(diff / (1000 * 60 * 60 * 24))+1);     }
    * def numberOfDays = dateDiff(formattedEndDate, formattedStartDate)
    * print 'Difference in days:', numberOfDays
    ###################
    * def grossIJSS = allIndemnities[0].periods[0].grossIJSS
    * print grossIJSS
    * def updatedGrossIJSS = grossIJSS + 1
    ###################
    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/lifecycle'
    * print "occurrenceId: " + occurrenceId
    And request {"occurrenceId": "#(occurrenceId)","receptionDate": "2022-10-06T18:07:51.777Z"}
    When method POST
    Then status 200
    * def lifecycleId = response.id
    * print "lifecycleId: " + lifecycleId
    * def sleep = function(pause){ java.lang.Thread.sleep(pause*1000) }
    * sleep(5)

    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/cdv/' + lifecycleId + '/occurrences/indemnities/ijss'
    * def uuid = java.util.UUID.randomUUID().toString()
    And request {"applyTo":["#(sinistreId)"],"id":"#(uuid)","ijss":{"startDate": "#(startDate)", "endDate": "#(endDate)", "numberOfDays": "#(numberOfDays)", "amount": "#(updatedGrossIJSS)"},"index":0}
    When method PUT
    Then status 200
    * print "update ijss: "

    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/cdv/' + lifecycleId + '/validate'
    When method POST
    Then status 202
    * print "Lyfecycle validé avec succee "

    # subscription
    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/lifecycle/subscription/' + lifecycleId
    When method GET
    Then status 200
    * print "subscription validé "

    * def cancledElementIds = karate.map(response.occurrenceChange.cancledElement, (element)=> `${element.id} [${element.instanceType} / ${element.status}]` )
    * print 'Liste des indemnity/payments annulé:', cancledElementIds

    * def createdElementIds = karate.map(response.occurrenceChange.createdElement, (element)=> `${element.id} [${element.instanceType} / ${element.status}]`)
    * print 'Liste des indemnity/payments créer:', createdElementIds

    # advanced
    * header Authorization = 'Bearer ' + accessToken
    Given url 'https://cdv-back1.prev-cdv-devb.openstack.local:8181/api/v1.0/lifecycle/' + lifecycleId + '/advanced'
    When method GET
    Then status 200
    * print "Traitement terminé  "


