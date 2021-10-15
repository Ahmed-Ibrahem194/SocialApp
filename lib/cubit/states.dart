
abstract class SocialStates{}

class SocialIntioalState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}


class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}



//Upload Profile Image States
class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}



//Upload Profile Image States
class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}



//Update Profile Image States
class SocialUpdateProfileImageSuccessState extends SocialStates{}

class SocialUpdateProfileImageErrorState extends SocialStates{}



//Update Cover Image States
class SocialUpdateCoverImageSuccessState extends SocialStates{}

class SocialUpdateCoverImageErrorState extends SocialStates{}



//Update User state
class SocialUserUpdateLoadingState extends SocialStates{}



//Creat Post States
class SocialCreatPostLoadingState extends SocialStates{}

class SocialCreatPostSuccessState extends SocialStates{}




//Upload Post Image States
class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}



//RemovePost Image States
class SocialRemovePostImageState extends SocialStates{}




//Get Posts
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}



//Like

class SocialLikePostsSuccessState extends SocialStates{}



//comment
class SocialCommentPostsSuccessState extends SocialStates{}





//get all users
class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}


//message
class SocialSendMessageSuccessState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}










