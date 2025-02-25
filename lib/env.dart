import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String type = _Env.type;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String projectId = _Env.projectId;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String privateKeyId = _Env.privateKeyId;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String privateKey = _Env.privateKey;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String clientEmail = _Env.clientEmail;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String clientId = _Env.clientId;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String authUri = _Env.authUri;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String tokenUri = _Env.tokenUri;

  @EnviedField(obfuscate: true, varName: 'AUTH_PROVIDER_X509_CERT_URL')
  static final String authProviderX509CertUrl = _Env.authProviderX509CertUrl;

  @EnviedField(obfuscate: true, varName: 'CLIENT_X509_CERT_URL')
  static final String clientX509CertUrl = _Env.clientX509CertUrl;

  @EnviedField(obfuscate: true, useConstantCase: true)
  static final String universeDomain = _Env.universeDomain;
}

/* 
type
project_id
private_key_id
private_key
client_email
client_id
auth_uri
token_uri
auth_provider_x509_cert_url
client_x509_cert_url
universe_domain
*/
