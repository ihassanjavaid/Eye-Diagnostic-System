import 'package:flutter_dialogflow/dialogflow_v2.dart';

class DialogFlowService{

  Future<AIResponse> getResponseFromDialogFlow(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/json/service.json").build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);

    return aiResponse;
  }

  Future<bool> getDialogFlowStatus() async {
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/json/service.json").build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent('hi');

    return aiResponse.queryResult.intent != null ;
  }

}