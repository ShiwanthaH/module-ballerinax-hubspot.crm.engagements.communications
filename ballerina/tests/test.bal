// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

// Copyright (c) {{LICENSE_YEAR}}, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerina/test;

configurable string hubspotClientId = ?;
configurable string hubspotClientSecret = ?;
configurable string hubspotRefreshToken = ?;

final boolean isLiveServer = true;
final string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/objects/communications" : "http://localhost:9090";

final Client hecClient = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: hubspotClientId,
            clientSecret: hubspotClientSecret,
            refreshToken: hubspotRefreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }

    return check new ({
        auth: {
            token: "test-token"
        }
    }, serviceUrl);
}

// batch

// @test:Config {}
// isolated function testCreateBatchOfMessages() returns error? {

//     BatchResponseSimplePublicObject response = check hecClient->/batch/create.post(
//         payload = {
//             inputs: [
//                 {
//                     associations: [
//                         {
//                             types: [
//                                 {
//                                     associationCategory: "HUBSPOT_DEFINED",
//                                     associationTypeId: 1
//                                 }
//                             ],
//                             to: {
//                                 id: "76300266232"
//                             }
//                         }
//                     ],
//                     objectWriteTraceId: "",
//                     properties: {
//                         "additionalProp1": "test"
//                     }
//                 }
//             ]
//         }
//     );

//     io:println("Response: ", response.toJsonString());

//     test:assertEquals(response is BatchResponseSimplePublicObject, true, "Response is not an instance of BatchResponseSimplePublicObject");
// }

@test:Config {}
isolated function testGetMessages() returns error? {

    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hecClient->/.get();

    io:println("Response: ", response.toJsonString());

    test:assertEquals(response is CollectionResponseSimplePublicObjectWithAssociationsForwardPaging, true, "Response is not an array of BatchResponseSimplePublicObject");
}

@test:Config {}
isolated function testGetMessageById() returns error? {

    SimplePublicObjectWithAssociations response = check hecClient->/["76300266232"].get();

    io:println("Response: ", response.toJsonString());

    test:assertEquals(response is SimplePublicObjectWithAssociations, true, "Response is not an instance of SimplePublicObjectWithAssociations");
}

@test:Config {}
isolated function testCreateMessage() returns error? {
    SimplePublicObject response = check hecClient->/.post(
        payload = {
            properties: {
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hubspot_owner_id": "77366318"
            },
            associations: [
                {
                    types: [
                        {
                            associationCategory: "HUBSPOT_DEFINED",
                            associationTypeId: 81
                        }
                    ],
                    to: {
                        id: "83849040631"
                    }
                },
                {
                    types: [
                        {
                            associationCategory: "HUBSPOT_DEFINED",
                            associationTypeId: 81
                        }
                    ],
                    to: {
                        id: "83849299661"
                    }
                }
            ]
        }
    );

    test:assertEquals(response is SimplePublicObject, true, "Response is not an instance of SimplePublicObject");
}

@test:Config {}
isolated function testUpdateMessage() returns error? {
    SimplePublicObject response = check hecClient->/["76300266232"].patch(
        payload = {
            properties: {
                "hs_communication_channel_type": "SMS",
                "hs_communication_logged_from": "CRM",
                "hs_communication_body": "Texted Linda to confirm that we're ready to move forward with the contract.",
                "hs_timestamp": "2022-11-12T15:48:22Z",
                "hubspot_owner_id": "77366318"
            }
        }
    );

    test:assertEquals(response is SimplePublicObject, true, "Response is not an instance of SimplePublicObject");
}

@test:Config {}
isolated function testDeleteMessage() returns error? {
    http:Response response = check hecClient->/["76300266232"].delete();

    test:assertEquals(response.statusCode == 204, true, "Failed to delete the message");
}
