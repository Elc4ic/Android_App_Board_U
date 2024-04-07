package org.example.Server.Utils;

import java.security.KeyPair;
import java.security.KeyPairGenerator;

public class KeyGeneratorUtil {

    public static KeyPair generateRsaKey(){
        KeyPair keyPair;
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(2048);
            keyPair = keyPairGenerator.generateKeyPair();
        }catch (Exception e){
            throw  new IllegalStateException();
        }

        return keyPair;
    }
}
