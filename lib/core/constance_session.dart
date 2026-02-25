class ConstantSession {
  static final ChoiceChild = 'child';
  static final ChoiceParent = 'parent';

  static final ReturnLoginChoicesEN = 'Return Login Choices';
  static final ReturnLoginChoicesFR = 'Retourner Aux Choix';

  static final LoginAsChildEN = 'Login as Child';
  static final LoginAsChildFR = 'Se Loguer Comme Enfant';

  static final LoginAsParentEN = 'Login as Parent';
  static final LoginAsParentFR = 'Se Loguer Comme Parent';

  static final CreateParentAccountEN = 'Create Parent Account';
  static final CreateParentAccountFR = 'Créer Compte Parent';

  static final ResetParentAccountEN = 'Reset Parent Account';
  static final ResetParentAccountFR = 'ReInitialiser Compte Parent';

  static final LoginTextEN = 'Login';
  static final LoginTextFR = 'Login';

  static final PasswordTextEN = 'Password';
  static final PasswordTextFR = 'Mot de passe';

  static final LoginButtonEN = 'Login';
  static final LoginButtonFR = 'Se Loguer';

  static final LogoutButtonEN = 'Logout';
  static final LogoutButtonFR = 'Se Déconnecter';

  static final LogoutTitleEN = 'Log out from application';
  static final LogoutTitleFR = "Se déconnecter de l'application";

  static final LogoutMessageEN =
      'Do you really want to sign out of your account?';
  static final LogoutMessageFR = "Voulez vous vraiment vous deconnecter ?";

  ////////////////////////////Activate Parent Account//////////////////////////////////////////////
  /*static final ActivationSuccessMessageEN =
      "Your account has been activated successfully. You can now login!";
  static final ActivationSuccessMessageFR =
      "Your account has been activated successfully. You can now login!";
  static final ActivationErrorMessageEN = "Error";
  static final ActivationErrorMessageFR = "Error";
  static final ResendActivationCodeEN =
      "Activation code has been sent into your mailbox.";
  static final ResendActivationCodeFR =
      "Activation code has been sent into your mailbox.";
  static final ResendActivationErrorMessageEN = "Error";
  static final ResendActivationErrorMessageFR = "Error";
  static final SuccessMessageEN = "Success";
  static final SuccessMessageFR = "Success";
  static final ContinueMessageEN = "Continue";
  static final ContinueMessageFR = "Success";
  static final ActivateAccountEN = "Activate Account";
  static final ActivateAccountFR = "Activate Account";
  static final EnterActivationCodeEN =
      "Enter the activation code sent by email";
  static final EnterActivationCodeFR =
      "Enter the activation code sent by email";
  static final ActivationCodeEN = "Activation Code";
  static final ActivationCodeFR = "Activation Code";
  static final ActivateAccountBetaEN = "Activate Account";
  static final ActivateAccountBetaFR = "Activate Account";
  static final ResendActivationCodeBetaEN = "Resend Activation Code";
  static final ResendActivationCodeBetaFR = "Resend Activation Code";
  static final RequiredEN = "Required";
  static final RequiredFR = "Required";

  /////////////////////////////////Create Parent Account/////////////////////////////////////////
  static final CreateParentAccountErrorMessageEN = "Error";
  static final CreateParentAccountErrorMessageFR = "Error";
  static final CreateParentAccountCreatedEN = "Account Created";
  static final CreateParentAccountCreatedFR = "Account Created";
  static final CreateParentAccountValidationMsgEN =
      "A validation code has been sent to your email.";
  static final CreateParentAccountValidationMsgFR =
      "A validation code has been sent to your email.";
  static final CreateParentAccountActivateEN = "Activate";
  static final CreateParentAccountActivateFR = "Activate";

  static final CreateParentAccountCreateParentAccountEN =
      "Create Parent Account";
  static final CreateParentAccountCreateParentAccountFR =
      "Create Parent Account";
  static final CreateParentAccountFirstNameEN = "First Name";
  static final CreateParentAccountFirstNameFR = "First Name";
  static final CreateParentAccountLastNameEN = "Last Name";
  static final CreateParentAccountLastNameFR = "Last Name";
  static final CreateParentAccountLoginEN = "Login";
  static final CreateParentAccountLoginFR = "Login";
  static final CreateParentAccountEmailEN = "Email";
  static final CreateParentAccountEmailFR = "Email";
  static final CreateParentAccountPasswordEN = "Password";
  static final CreateParentAccountPasswordFR = "Password";
  static final CreateParentAccountCreateAccountEN = "Create Account";
  static final CreateParentAccountCreateAccountFR = "Create Account";
  static final CreateParentAccountRequiredEN = "Required";
  static final CreateParentAccountRequiredFR = "Required";

  ///////////////////////////////// Parent Reset password/////////////////////////////////////////
  static final ParentResetPasswordPasswordsNotMatchEN =
      "Passwords do not match";
  static final ParentResetPasswordPasswordsNotMatchFR =
      "Passwords do not match";
  static final ParentResetPasswordErrorEN = "Error";
  static final ParentResetPasswordErrorFR = "Error";
  static final ParentResetPasswordSuccessEN = "Success";
  static final ParentResetPasswordSuccessFR = "Success";
  static final ParentResetPasswordPasswordResetSuccessfullyEN =
      "Password reset successfully.";
  static final ParentResetPasswordPasswordResetSuccessfullyFR =
      "Password reset successfully.";
  static final ParentResetPasswordContinueEN = "Continue";
  static final ParentResetPasswordContinueFR = "Continue";
  static final ParentResetPasswordResetPasswordEN = "Reset Password";
  static final ParentResetPasswordResetPasswordFR = "Reset Password";
  static final ParentResetPasswordEnterYourEmailEN =
      "Enter your email, reset code and new password";
  static final ParentResetPasswordEnterYourEmailFR =
      "Enter your email, reset code and new password";
  static final ParentResetPasswordEmailEN = "Email";
  static final ParentResetPasswordEmailFR = "Email";
  static final ParentResetPasswordResetCodeEN = "Reset Code";
  static final ParentResetPasswordResetCodeFR = "Reset Code";
  static final ParentResetPasswordNewPasswordEN = "New Password";
  static final ParentResetPasswordNewPasswordFR = "New Password";
  static final ParentResetPasswordConfirmPasswordEN = "Confirm Password";
  static final ParentResetPasswordConfirmPasswordFR = "Confirm Password";
  static final ParentResetPasswordResetPasswordBtnEN = "Reset Password";
  static final ParentResetPasswordResetPasswordBtnFR = "Reset Password";
  static final ParentResetPasswordRequiredEN = "Required";
  static final ParentResetPasswordRequiredFR = "Required";
  ///////////////////////////////// Parent Reset/////////////////////////////////////////
  static final ParentResetErrorMsgEN = "Error";
  static final ParentResetErrorMsgFR = "Error";
  static final ParentResetEmailSentEN = "Email Sent";
  static final ParentResetEmailSentFR = "Email Sent";
  static final ParentResetEmailSentMsgEN =
      "A reset code has been sent to your email.";
  static final ParentResetEmailSentMsgFR =
      "A reset code has been sent to your email.";
  static final ParentResetContinueEN = "Continue";
  static final ParentResetContinueFR = "Continue";
  static final ParentResetResetPasswordReceivedResetCodeEN =
      "Reset Password: Received Reset Code";
  static final ParentResetResetPasswordReceivedResetCodeFR =
      "Reset Password: Received Reset Code";
  static final ParentResetEnterYourEmailEN =
      "Enter your email to receive a reset code";
  static final ParentResetEnterYourEmailFR =
      "Enter your email to receive a reset code";
  static final ParentResetEmailRequiredEN = "Email required";
  static final ParentResetEmailRequiredFR = "Email required";
  static final ParentResetEmailEN = "Email";
  static final ParentResetEmailFR = "Email";
  static final ParentResetSendResetCodeBtnEN = "Send Reset Code";
  static final ParentResetSendResetCodeBtnFR = "Send Reset Code";*/
  static final ActivationSuccessMessageEN =
      "Your account has been activated successfully. You can now login!";
  static final ActivationSuccessMessageFR =
      "Votre compte a été activé avec succès. Vous pouvez maintenant vous connecter.";

  static final ActivationErrorMessageEN = "Error";
  static final ActivationErrorMessageFR = "Erreur";

  static final ResendActivationCodeEN =
      "Activation code has been sent into your mailbox.";
  static final ResendActivationCodeFR =
      "Le code d'activation a été envoyé dans votre boîte mail.";

  static final ResendActivationErrorMessageEN = "Error";
  static final ResendActivationErrorMessageFR = "Erreur";

  static final SuccessMessageEN = "Success";
  static final SuccessMessageFR = "Succès";

  static final ContinueMessageEN = "Continue";
  static final ContinueMessageFR = "Continuer";

  static final ActivateAccountEN = "Activate Account";
  static final ActivateAccountFR = "Activer le compte";

  static final EnterActivationCodeEN =
      "Enter the activation code sent by email";
  static final EnterActivationCodeFR =
      "Entrez le code d'activation envoyé par email";

  static final ActivationCodeEN = "Activation Code";
  static final ActivationCodeFR = "Code d'activation";

  static final ActivateAccountBetaEN = "Activate Account";
  static final ActivateAccountBetaFR = "Activer le compte";

  static final ResendActivationCodeBetaEN = "Resend Activation Code";
  static final ResendActivationCodeBetaFR = "Renvoyer le code d'activation";

  static final RequiredEN = "Required";
  static final RequiredFR = "Obligatoire";

///////////////////////////////Create Parent Account/////////////////////////////////////////

  static final CreateParentAccountErrorMessageEN = "Error";
  static final CreateParentAccountErrorMessageFR = "Erreur";

  static final CreateParentAccountCreatedEN = "Account Created";
  static final CreateParentAccountCreatedFR = "Compte créé";

  static final CreateParentAccountValidationMsgEN =
      "A validation code has been sent to your email.";
  static final CreateParentAccountValidationMsgFR =
      "Un code de validation a été envoyé à votre adresse email.";

  static final CreateParentAccountActivateEN = "Activate";
  static final CreateParentAccountActivateFR = "Activer";

  static final CreateParentAccountCreateParentAccountEN =
      "Create Parent Account";
  static final CreateParentAccountCreateParentAccountFR =
      "Créer un compte parent";

  static final CreateParentAccountFirstNameEN = "First Name";
  static final CreateParentAccountFirstNameFR = "Prénom";

  static final CreateParentAccountLastNameEN = "Last Name";
  static final CreateParentAccountLastNameFR = "Nom";

  static final CreateParentAccountLoginEN = "Login";
  static final CreateParentAccountLoginFR = "Identifiant";

  static final CreateParentAccountEmailEN = "Email";
  static final CreateParentAccountEmailFR = "Email";

  static final CreateParentAccountPasswordEN = "Password";
  static final CreateParentAccountPasswordFR = "Mot de passe";

  static final CreateParentAccountCreateAccountEN = "Create Account";
  static final CreateParentAccountCreateAccountFR = "Créer un compte";

  static final CreateParentAccountRequiredEN = "Required";
  static final CreateParentAccountRequiredFR = "Obligatoire";

/////////////////////////////// Parent Reset password/////////////////////////////////////////

  static final ParentResetPasswordPasswordsNotMatchEN =
      "Passwords do not match";
  static final ParentResetPasswordPasswordsNotMatchFR =
      "Les mots de passe ne correspondent pas";

  static final ParentResetPasswordErrorEN = "Error";
  static final ParentResetPasswordErrorFR = "Erreur";

  static final ParentResetPasswordSuccessEN = "Success";
  static final ParentResetPasswordSuccessFR = "Succès";

  static final ParentResetPasswordPasswordResetSuccessfullyEN =
      "Password reset successfully.";
  static final ParentResetPasswordPasswordResetSuccessfullyFR =
      "Mot de passe réinitialisé avec succès.";

  static final ParentResetPasswordContinueEN = "Continue";
  static final ParentResetPasswordContinueFR = "Continuer";

  static final ParentResetPasswordResetPasswordEN = "Reset Password";
  static final ParentResetPasswordResetPasswordFR =
      "Réinitialiser le mot de passe";

  static final ParentResetPasswordEnterYourEmailEN =
      "Enter your email, reset code and new password";
  static final ParentResetPasswordEnterYourEmailFR =
      "Entrez votre email, le code de réinitialisation et le nouveau mot de passe";

  static final ParentResetPasswordEmailEN = "Email";
  static final ParentResetPasswordEmailFR = "Email";

  static final ParentResetPasswordResetCodeEN = "Reset Code";
  static final ParentResetPasswordResetCodeFR = "Code de réinitialisation";

  static final ParentResetPasswordNewPasswordEN = "New Password";
  static final ParentResetPasswordNewPasswordFR = "Nouveau mot de passe";

  static final ParentResetPasswordConfirmPasswordEN = "Confirm Password";
  static final ParentResetPasswordConfirmPasswordFR =
      "Confirmer le mot de passe";

  static final ParentResetPasswordResetPasswordBtnEN = "Reset Password";
  static final ParentResetPasswordResetPasswordBtnFR =
      "Réinitialiser le mot de passe";

  static final ParentResetPasswordRequiredEN = "Required";
  static final ParentResetPasswordRequiredFR = "Obligatoire";

/////////////////////////////// Parent Reset/////////////////////////////////////////

  static final ParentResetErrorMsgEN = "Error";
  static final ParentResetErrorMsgFR = "Erreur";

  static final ParentResetEmailSentEN = "Email Sent";
  static final ParentResetEmailSentFR = "Email envoyé";

  static final ParentResetEmailSentMsgEN =
      "A reset code has been sent to your email.";
  static final ParentResetEmailSentMsgFR =
      "Un code de réinitialisation a été envoyé à votre adresse email.";

  static final ParentResetContinueEN = "Continue";
  static final ParentResetContinueFR = "Continuer";

  static final ParentResetResetPasswordReceivedResetCodeEN =
      "Reset Password: Received Reset Code";
  static final ParentResetResetPasswordReceivedResetCodeFR =
      "Réinitialisation du mot de passe : code reçu";

  static final ParentResetEnterYourEmailEN =
      "Enter your email to receive a reset code";
  static final ParentResetEnterYourEmailFR =
      "Entrez votre email pour recevoir un code de réinitialisation";

  static final ParentResetEmailRequiredEN = "Email required";
  static final ParentResetEmailRequiredFR = "Email requis";

  static final ParentResetEmailEN = "Email";
  static final ParentResetEmailFR = "Email";

  static final ParentResetSendResetCodeBtnEN = "Send Reset Code";
  static final ParentResetSendResetCodeBtnFR =
      "Envoyer le code de réinitialisation";
}
