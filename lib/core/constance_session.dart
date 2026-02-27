class ConstantSession {
  /*tatic String BottomHomeEN = 'Home';
  static String BottomHomeFR = 'Accueil';
  static String BottomOperationEN = 'Operations';
  static String BottomOperationFR = 'Operations';
  static String BottomStatisticsEN = 'Statistics';
  static String BottomStatisticsFR = 'Statistiques';
  static String BottomPaymentEN = 'Payments';
  static String BottomPaymentFR = 'Paiements';
  
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
*/}
