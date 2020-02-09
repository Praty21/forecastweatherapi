@error-scenarios
Feature:
    Testing the Error Scenarios

    @Error_missing_phone    
    Scenario: error check
        Given I set body to {"email":"pratysin@gmail.com","first_name":"Pratyush","last_name":"Singh","phone":"8197703300",user":"employee"}
        When I POST to /weatherapi
        Then response code should be 911
        And response body path $.error should be missing phone details from payload    


    @Error_invalid_id
    Scenario: Invalid ID returns 404 code response
        Given I set Content-type header to application/json
        When I GET /weatherapi/invalid_id
        Then response code should be 404
        And response body path $.error should be invlaid id no record found    

    @Error_fault_rule
    Scenario: Invalid String length returns custom error response
        Given I set body to {"email":"pratysin@gmail.com","first_name":"Pratyush","last_name":"Singh","phone":"8197703300","user":"employee"}
        And I set headers to
	      | name          | value 			 |
	      | Content-Type  | application/json |
        When I POST to /weatherapi
        Then response code should be 400
        And response body path $.error should be string length exceed more than 15 characters 
