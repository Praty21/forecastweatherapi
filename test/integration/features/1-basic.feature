@basic-operations
Feature:
    Testing the CRUD Operations
        
    @POST_create_record    
    Scenario: Create a User Record
        Given I set body to {"email":"pratysin@gmail.com","first_name":"Pratyush","last_name":"Singh","phone":"8197703300","user":"employee"}
        And I set headers to
	      | name          | value 			 |
	      | Content-Type  | application/json |
        When I POST to /weatherapi
        Then response code should be 200
        And response body path $.id should be 8197703300Pratyush
        And response body path $.name should be Pratyush Singh
        And response body path $.account should be Active

    @GET_all_records    
    Scenario: Read all records and check status code
        Given I set Content-type header to application/json
        When I GET /weatherapi
        Then response code should be 200    
    
    @GET_specific_record    
    Scenario: retrieve a specific user record
        Given I set Content-type header to application/json
        When I GET /weatherapi/8197703300Pratyush
        Then response code should be 200


