Feature: Testing the API's

Scenario: Get Subscribed customer details
Given I create a new request with http://apiops1-anypoint-bdd-sapi.us-e2.cloudhub.io/api/ service
And I add the users/registerUser/subscription endpoint to the service
And I send the GET request to the service
Then I get the 200 response code

Scenario: Register Customer 
Given I create a new request with http://apiops1-anypoint-bdd-sapi.us-e2.cloudhub.io/api/ service
And I add the users/registerUser endpoint to the service
And  I pass application/json as content type
And I send the values of src/test/resources/cucumberResources/registerCustomerInput.json in the request body
And I send the POST request to the service
Then I get the 201 response code
Then I expect the values of src/test/resources/cucumberResources/registerCustomerOutput.json in the response body

Scenario: Test the scheduler part
Given I create a new request with http://apiops-anypoint-bdd-papi.us-e2.cloudhub.io/ service
And I add the synchronize endpoint to the service
And I send the GET request to the service
Then I get the 200 response code

