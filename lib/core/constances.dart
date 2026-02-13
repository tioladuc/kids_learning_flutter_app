import 'package:flutter/material.dart';

class Constant {

  static final AppNameFR = 'Kids Learning FR';
  static final AppNameEN = 'Kids Learning EN';
  static final String languageFR = 'FR';
  static final String languageEN = 'EN';

  static final String readingSpeedFR = 'Vitesse de Lecture : ';
  static final String readingSpeedEN = 'Reading Speed : ';

  static final String listingAudioTitleFR = 'Liste Des Dictées';
  static final String listingAudioTitleEN = 'List Of Dictations';
  static final String readingAudioTitleFR = 'Faisons Notre Dictée';
  static final String readingAudioTitleEN = 'Let us Do Dictation';
  static final String deleteAudioFR = 'Suppression audio';
  static final String deleteAudioEN = 'Delete audio';

  static final String areYouSureAudioFR = 'Êtes vous sûr ?';
  static final String areYouSureAudioEN = 'Are you sure ?';

  static final String cancelFR = 'Annuler';
  static final String cancelEN = 'Cancel';

  static final String deleteFR = 'Supprimer';
  static final String deleteEN = 'Delete';

  static String currentLanguage = 'EN';


 static ButtonStyle getTitle1ButtonStyle() {
    return ElevatedButton.styleFrom(
    backgroundColor: Colors.blue, // Background color of the button
    foregroundColor: Colors.white, 
    textStyle:  TextStyle(height: 1, fontSize: 25),// Text/Icon color
    
  );
  } 

  static ButtonStyle getTitle1ButtonStyleBlack() {
    return ElevatedButton.styleFrom(
    backgroundColor: Colors.black, // Background color of the button
    foregroundColor: Colors.white, 
    textStyle:  TextStyle(height: 1, fontSize: 25),// Text/Icon color
    
  );
  } 
  static ButtonStyle getTitle1ButtonStyleWhite() {
    return ElevatedButton.styleFrom(
    backgroundColor: Colors.white, // Background color of the button
    foregroundColor: Colors.black, 
    textStyle:  TextStyle(height: 1, fontSize: 25),// Text/Icon color
    
  );
  } 

  static ButtonStyle getTitle3ButtonStyle() {
    return ElevatedButton.styleFrom(
    backgroundColor: Colors.lightBlue, // Background color of the button
    foregroundColor: Colors.white, 
    textStyle:  TextStyle(height: 1, fontSize: 15),// Text/Icon color
    
  );
  } 
  /***********************************************************/
  static TextStyle getTitleStyle() {
    return TextStyle(      
    color: Colors.lightBlue, 
    fontSize: 25,
    fontWeight: FontWeight.bold,
    
  );
  } 
  static TextStyle getTextStyle() {
    return TextStyle(
    color: Colors.black, 
    fontStyle: FontStyle.italic,
    fontSize: 15,
    
  );
  } 
  static TextStyle getTextSimpleStyle() {
    return TextStyle(
    color: Colors.lightBlue, 
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 15,
    
  );
  } 
  static ButtonStyle getButtonSimpleSelectedStyle() {
    return IconButton.styleFrom(
    backgroundColor: Colors.blue, // Custom background color
    foregroundColor: Colors.white, // Custom icon color
  );
  }
  static ButtonStyle getButtonSimpleStyle() {
    return IconButton.styleFrom(
    backgroundColor: Colors.white, // Custom background color
    foregroundColor: Colors.black, // Custom icon color
  );
  } 
}