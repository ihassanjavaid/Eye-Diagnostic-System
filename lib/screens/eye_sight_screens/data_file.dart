class Data1{
String rightEyeVAT;
String leftEyeVAT;
String rightEyeDCT;
String leftEyeDCT;
String rightEyeCST;
String leftEyeCST;
bool right, left  = false;

set rightVAT (String val){
  this.rightEyeVAT = val;
}
String get leftVAT {
  return leftEyeVAT;
}

set rightDCT (String val){
  this.rightEyeDCT = val;
}
String get rightDCT {
  return this.rightEyeDCT;
}
set leftDCT (String val){
  this.leftEyeDCT = val;
}
String get leftDCT {
  return this.leftEyeDCT;
}




}


