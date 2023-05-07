#!/bin/bash

echo "########### Creating table with global secondary index ###########"
aws   $AWS_ENDPOINT \
      dynamodb create-table \
         --table-name Order \
         --attribute-definitions \
           AttributeName=CustomerID,AttributeType=S \
           AttributeName=OrderID,AttributeType=S \
        --key-schema AttributeName=CustomerID,KeyType=HASH \
        --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
        --global-secondary-indexes \
                  "[
                      {
                          \"IndexName\": \"OrderID\",
                          \"KeySchema\": [{\"AttributeName\":\"OrderID\",\"KeyType\":\"HASH\"}],
                          \"Projection\":{
                              \"ProjectionType\":\"ALL\"
                          },
                          \"ProvisionedThroughput\": {
                              \"ReadCapacityUnits\": 5,
                              \"WriteCapacityUnits\": 5
                          }
                      }
                  ]"

echo "########### Describing a table ###########"
aws   $AWS_ENDPOINT \
      dynamodb describe-table --table-name Order --output table
#
#echo "########### Inserting test data into a table ###########"
#aws   $AWS_ENDPOINT \
#      dynamodb put-item --table-name Air_Shopping_Responses --item "{\"id\":{\"S\":\"29ae2e26-76df-4211-a8e8-f26f11b11588\"},
#                                                     \"phone_number\":{\"S\":\"1-962-894-4629\"},
#                                                     \"title\":{\"S\":\"Mr\"},
#                                                     \"fullName\":{\"S\":\"Jarrod Kub V\"},
#                                                     \"address\":{\"S\":\"94912 Kihn Club, Lake Twana, AR 58508\"},
#                                                     \"createdAt\":{\"S\":\"2021-09-26\"},
#                                                     \"purchaseTransactions\":{\"L\":[{
#                                                                                    \"M\":{
#                                                                                           \"id\":{\"S\":\"29ae2e26-76df-4211-a8e8-f26f11b11588\"},
#                                                                                           \"paymentType\":{\"S\":\"VISA\"},
#                                                                                           \"amount\":{\"N\":\"53.96\"},
#                                                                                           \"createdAt\":{\"S\":\"2019-04-05\"}
#                                                                                           }
#                                                                                      }]
#                                                            }}"



echo "########### Selecting all data from a table ###########"
aws   $AWS_ENDPOINT \
      dynamodb scan --table-name Order