
int i = 0;
void setup() {
  pinMode(A2, INPUT);
  pinMode(A1, OUTPUT);
  digitalWrite(A1, HIGH);  
  pinMode(LED_BUILTIN, OUTPUT);  
  Serial.begin(9600);
}

void loop() {
  Serial.println(digitalRead(A2));
  
  if(i > 180){  
    if(digitalRead(A2) == LOW){
      Serial.println("Signal Detecte, on eteint.");
      delay(20);                       
      digitalWrite(A1, LOW);
    }
  }
  if(i > 900){  // Aucun signal reçu au bout de 15min, on eteint pour economiser la batterie
      digitalWrite(A1, LOW);
  }
  delay(1000);  // wait for a second
  i++;
}
