abstract class CustomValidator{
  static final RegExp nameRegExp = RegExp('^[a-zA-Z]+');
  static final RegExp numberRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
  static final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static Map<String,dynamic> isNameValid(String input){
    Map<String,dynamic> assessment= {"result":false,"message":""};
    if(nameRegExp.hasMatch(input)&& input.length<30 &&input.length>1&&input.isNotEmpty ){
       assessment["result"]=true;
    }else{
      assessment["result"]=false;
      if(input.length>30){
        assessment["message"]="name is too long, length accepted  is 1<length<30 characters";
      }else if(!nameRegExp.hasMatch(input)&&input.isNotEmpty){
        assessment["message"]="a valid name must only contain a-z or A-Z";
      }else if(input.length==1){
        assessment["message"]="name is too short, length accepted  is 1<length<30 characters";
      }else{
        assessment["message"]="can not login with empty fields";
      }
    }
    return assessment;
  }
}