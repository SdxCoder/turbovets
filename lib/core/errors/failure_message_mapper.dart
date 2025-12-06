import 'failures.dart';

class FailureMessageMapper {
  FailureMessageMapper._();

  static ({String title, String message}) mapFailureToMessage(Failure failure) {
    return switch (failure) {
      InvalidEmailFailure() => (
        title: '',
        message: 'Please enter a valid email address',
      ),
      InvalidPasswordFailure() => (
        title: 'Bad Request',
        message: 'Password must be at least 6 characters long',
      ),
      InvalidNameFailure() => (
        title: 'Bad Request',
        message: 'Name must be at least 3 characters long',
      ),
      UserNotFoundFailure() => (
        title: 'User Not Found',
        message: 'User not found. Please check your credentials',
      ),
      InvalidCredentialsFailure() => (
        title: 'Invalid Credentials',
        message: 'Invalid email or password',
      ),
      UserDataNotFoundFailure() => (
        title: 'User Data Not Found',
        message: 'User data not found. Please try again',
      ),
      EmailAlreadyExistsFailure() => (
        title: 'Bad Request',
        message: 'Email already exists. Please use a different email',
      ),
      CacheFailure(:final code) => (
        title: 'Cache Error',
        message: code ?? 'Unable to load cached data. Please try again',
      ),
      FailedToRegisterUserFailure() => (
        title: 'Registration Failed',
        message: 'Failed to register user. Please try again',
      ),
      ChatAlreadyExistsFailure() => (
        title: 'Chat Already Exists',
        message: 'A chat with this agent already exists',
      ),
      ChatNotFoundFailure() => (
        title: 'Chat Not Found',
        message: 'Chat not found. Please try again',
      ),
      FailedToStartChatFailure() => (
        title: 'Failed to Start Chat',
        message: 'Failed to start chat. Please try again',
      ),
      FailedToSendMessageFailure() => (
        title: 'Failed to Send Message',
        message: 'Failed to send message. Please try again',
      ),
      FailedToGetMessagesFailure() => (
        title: 'Failed to Get Messages',
        message: 'Failed to get messages. Please try again',
      ),
      NoImagesSelectedFailure() => (
        title: 'No Images Selected',
        message: 'Please select at least one image',
      ),
      ImagePickCancelledFailure() => (title: '', message: ''),
      ImagePickPermissionDeniedFailure() => (
        title: 'Permission Denied',
        message:
            'Please give access to your gallery to select images. Open settings and grant permission to access your gallery.',
      ),
      ImagePickPlatformFailure() => (
        title: 'Oops!',
        message: 'Something went wrong. Please try again later.',
      ),
      UnknownFailure(:final code) => (
        title: 'Unknown Error',
        message: code ?? 'An unexpected error occurred. Please try again',
      ),
    };
  }
}

typedef FailureMessage = ({String title, String message});
