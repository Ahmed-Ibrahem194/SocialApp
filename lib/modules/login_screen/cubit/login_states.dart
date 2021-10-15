
abstract class SocialLoginStates{}

class InitialLoginStates extends SocialLoginStates{}


class SocialLoginLoadingStates extends SocialLoginStates{}


class SocialLoginSuccessfulStates extends SocialLoginStates
{
  final String uId;
  SocialLoginSuccessfulStates(this.uId);
}



class SocialLoginSuffixChangeStates extends SocialLoginStates{}


class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

