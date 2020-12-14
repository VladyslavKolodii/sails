const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-west-1:18d6878a-4091-4346-ab9a-aa66a4e3b661",
                            "Region": "eu-west-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-1_FUKgjk8iV",
                        "AppClientId": "2fvoha0kmh15ivnjbvh5jva8k0",
                        "AppClientSecret": "mtm655iv3a21snclh9fp4tvgm34ub828p4ig7h45v4iuhh2a91f",
                        "Region": "eu-west-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "CUSTOM_AUTH"
                    }
                }
            }
        }
    }
}''';
