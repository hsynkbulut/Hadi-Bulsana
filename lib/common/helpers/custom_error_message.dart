class CustomErrorMessage {
  static String getForgotPasswordErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "Bu bilgilere sahip bir kullanıcı kaydı yok.";
      case "invalid-email":
        return "Geçersiz email adresi.";
      default:
        return "Bir hata oluştu.";
    }
  }

  static String getRegisterErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Geçersiz email adresi.";
      case "email-already-in-use":
        return "Belirtilen e-posta adresine sahip bir hesap zaten var.";
      case "invalid-phone-number":
        return "Geçersiz telefon numarası.";
      case "invalid-photo-url":
        return "photoURL kullanıcı özelliği için sağlanan değer geçersiz. Bir dize URL'si olmalıdır.";
      case "weak-password":
        return "Belirlemiş olduğunuz parola yeterince güçlü değil.";
      case "invalid-password":
        return "Parola geçersiz. En az altı karakterden oluşan bir dize olmalıdır.";
      case "network-request-failed":
        return "Lütfen internet bağlantınızı kontrol edin";
      default:
        return "Bir hata oluştu.";
    }
  }

  static String getLoginErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "Bu bilgilere sahip bir kullanıcı kaydı yok.";
      case "invalid-email":
        return "Geçersiz email adresi.";
      case "wrong-password":
        return "Şifre yanlış veya geçersiz.";
      case "network-request-failed":
        return "Lütfen internet bağlantınızı kontrol edin";
      default:
        return "Bir hata oluştu.";
    }
  }

  static String getUpdateUserErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Geçersiz email adresi.";
      case "weak-password":
        return "Belirlemiş olduğunuz parola yeterince güçlü değil.";
      case "invalid-password":
        return "Parola geçersiz. En az altı karakterden oluşan bir dize olmalıdır.";
      case "network-request-failed":
        return "Bir ağ hatası (zaman aşımı, kesilen bağlantı veya ulaşılamayan ana bilgisayar gibi) oluştu.";
      case "requires-recent-login":
        return "Bu işlem hassastır ve yeni kimlik doğrulaması gerektirir. Bu isteği yeniden denemeden önce tekrar oturum açın.";
      default:
        return "Bir hata oluştu.";
    }
  }
}
