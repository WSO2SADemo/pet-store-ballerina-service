import ballerina/io;
import ballerina/http;
import ballerina/log;

type Pet record {
    int id = -1;
    string name = "-1";
    string description = "-1";
};

type ErrorRecord record {|
    *http:InternalServerError;
    record {
        string message;
    } body;
|};

// @http:ServiceConfig {
//     cors: {
//         allowOrigins: ["http://localhost:3000"],
//         allowCredentials: false,
//         allowHeaders: ["CORELATION_ID"],
//         exposeHeaders: ["X-CUSTOM-HEADER"],
//         maxAge: 84900
//     }
// }
service /petstore/rest on new http:Listener(9091) {

    function init() returns error? {
        log:printInfo("Service Initiated !");
    }

    resource function get getPets() returns Pet[] {
        io:println("purchaseItems() called: ");
        Pet[] pets = [];
        // Pet pet = {id: 12, name: "abc", description: "descrption1"};
        pets.push({id: 13, name: "abc", description: "description1"});
        pets.push({id: 14, name: "pqr", description: "description2"});
        io:println(pets);
        return pets;
    }

    resource function post addPet(@http:Payload map<json> mapJson) returns string {
        io:println("addPet() called: ");
        string name = <string>mapJson["name"];
        return "Successfully added the new pet: " + name;
    }

    resource function put updatePet(@http:Payload map<json> mapJson) returns string {
        io:println("updatePet() called: ");
        string name = <string>mapJson["name"];
        return "Successfully updated the petstore for pet: " + name;
    }


    resource function delete deletePet(string idstring) returns string {
        io:println("updateDeliveryStatus() called: ");
        return "Successfully deleted the pet: " + idstring;
    }

    resource function get pet(int itemId) returns Pet|ErrorRecord {
        return {id: itemId, name: "abc", description: "descrption1"};
    }

    resource function get test() returns Pet|ErrorRecord {
        return {id: -1, name: "test", description: "descrption test"};
    }

    resource function get simulateError() returns ErrorRecord {
        ErrorRecord errorResponse = {
            // Populating the fields inherited from `http:InternalServerError`
            body: {
                message: "An unexpected error occurred."
            }
        };
        return errorResponse;
    }

}
