import Foundation

extension Fixture {

    /// A dev `misc/config-list` response envelope with every secret replaced by `REDACTED_n`.
    static let configListEnvelope = #"""
        {
          "status": 200,
          "success": true,
          "message": "Success",
          "data": {
            "apiKey": "REDACTED_32",
            "whiteLabels": {
              "reverseProxyUrl": "https://example.execute-api.eu-west-1.amazonaws.com",
              "brandName": "Cruise Genie",
              "cookieConsentUrl": "",
              "brandUrl": "",
              "landingPageUrl": "",
              "imagePaths": {
                "logoPathDark": "https://poi-pics.s3.eu-west-1.amazonaws.com/project-images/tripian-one/logo.png",
                "logoPathLight": "https://poi-pics.s3.eu-west-1.amazonaws.com/project-images/tripian-one/logo.png",
                "formHeaderImgUrl": "",
                "formBgImgUrl": "",
                "appBackgroundImgUrl": ""
              },
              "theme": {
                "dark": {
                  "background": "#f5f5f5",
                  "danger": "#e54e53",
                  "headerBg": "#ffffff",
                  "headerTextColor": "#000000",
                  "info": "#333232",
                  "primary": "#e9314a",
                  "secondary": "#ffeef0",
                  "success": "#2da52d",
                  "textPrimary": "#434b55",
                  "warning": "#f9a938"
                },
                "light": {
                  "background": "#f5f5f5",
                  "danger": "#e54e53",
                  "headerBg": "#ffffff",
                  "headerTextColor": "#000000",
                  "info": "#333232",
                  "primary": "#e9314a",
                  "secondary": "#ffeef0",
                  "success": "#2da52d",
                  "textPrimary": "#434b55",
                  "warning": "#f9a938"
                }
              },
              "availableThemes": [
                "light"
              ],
              "googleAnalyticsUrl": {
                "customer": "",
                "business": ""
              },
              "googleAnalyticsKey": {
                "customer": "",
                "business": ""
              },
              "providers": [],
              "cognito": {
                "clientId": "REDACTED_26",
                "domain": "example-domain",
                "region": "eu-west-1",
                "identityProviders": [
                  "Google",
                  "SignInWithApple"
                ]
              },
              "rootPath": "",
              "ppUrl": "https://www.tripian.com/terms-conditions.html",
              "tosUrl": "https://www.tripian.com/privacy-policy.html",
              "defaultDestinationId": 0,
              "languages": [
                "en",
                "de",
                "es"
              ],
              "dealsPageUrl": "",
              "externalMenuLinks": {},
              "priorityTourIds": {},
              "registerFields": []
            },
            "baseFeatures": {
              "showRegister": true,
              "guestLogin": false,
              "showLogin": true,
              "showSideNav": true,
              "showHome": true,
              "showUserProfile": true,
              "showChangePassword": true,
              "showTripModeQuestion": true,
              "showCreateTrip": true,
              "showUpdateTrip": true,
              "showOverview": false,
              "showOffers": true,
              "showStepCardThumbs": true,
              "showStepScoreDetail": false,
              "loginWithToken": true,
              "loginWithHash": true,
              "saveSession": true,
              "showTravelGuide": false,
              "showVoucher": false,
              "showSaveTrip": false,
              "showTimeline": false,
              "showAccommodationPois": false,
              "sharedTrip": false,
              "enableCustomPoiCreation": true,
              "enableCustomEventCreation": true,
              "showCustomPoiResults": true,
              "qrReader": "business",
              "widgetTheme1": false,
              "widgetTheme2": false,
              "widgetTheme3": false,
              "apiLoggingEnabled": false,
              "landingPage": "LandingPage",
              "featuredItineraries": [],
              "keyFlags": []
            },
            "providers": {
              "tourAndTicket": [
                {
                  "id": 1,
                  "name": "viator",
                  "apiKey": "REDACTED_36",
                  "apiUrl": "https://api.sandbox.viator.com/partner/",
                  "clientId": "",
                  "limit": 50,
                  "prod": false
                },
                {
                  "id": 12,
                  "name": "Toristy",
                  "apiKey": "REDACTED_30",
                  "apiUrl": "https://api.toristy.com",
                  "clientId": "",
                  "limit": 50,
                  "prod": true
                },
                {
                  "id": 13,
                  "name": "Victory",
                  "apiKey": "REDACTED_32",
                  "apiUrl": "https://api.sandbox.ticketevolution.com",
                  "clientId": "",
                  "limit": 50,
                  "prod": false
                }
              ],
              "transportation": [
                {
                  "id": 9,
                  "name": "uber",
                  "apiKey": "",
                  "apiUrl": "",
                  "clientId": "REDACTED_32",
                  "limit": 50,
                  "prod": false
                }
              ],
              "restaurant": [
                {
                  "id": 5,
                  "name": "opentable",
                  "apiKey": "",
                  "apiUrl": "",
                  "clientId": "",
                  "limit": 50,
                  "prod": false
                },
                {
                  "id": 2,
                  "name": "yelp",
                  "apiKey": "REDACTED_128",
                  "apiUrl": "https://api.yelp.com/v3",
                  "clientId": "",
                  "limit": 50,
                  "prod": false
                }
              ],
              "accommodation": []
            },
            "sbt": {
              "campaignDefaultCurrency": "",
              "offerTypes": [
                "percentage",
                "amount",
                "quantity",
                "spend_for_gift"
              ]
            },
            "androidVersionCode": 0,
            "androidVersionName": "",
            "aiSupport": false
          },
          "UUID": "00000000000000000000000000000000"
        }
        """#
}
