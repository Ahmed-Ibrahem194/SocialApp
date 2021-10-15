
abstract class SocialRegisterStates{}

class SocialRegiterInitialStates extends SocialRegisterStates{}

class SocialRegiterLoadingStates extends SocialRegisterStates{}


class SocialRegisterSuccessfulStates extends SocialRegisterStates{}


class SocialRegisterErrorStates extends SocialRegisterStates
{
  final String error;
  SocialRegisterErrorStates(this.error);
}

class SocialRegisterSuffixChangeStates extends SocialRegisterStates{}

class SocialCreatUserSuccessfulState extends SocialRegisterStates{}



class SocialCreatUserErrorStates extends SocialRegisterStates
{
  final String error;
  SocialCreatUserErrorStates(this.error);
}
