final int tempo_fechada = 1000;
final int tempo_aberta = 1500;
final int num_janelas = 16; //SOMENTE QUADRADOS PERFEITOS!!!
Janela[] janelas = new Janela[num_janelas];   
int tempo = millis();
int janela_atual = -1;

void setup() {
  size(1000,686);
  for (int I=0; I < num_janelas; I++){
    janelas[I] = new Janela(this, num_janelas, I+1);
    janelas[I].exibe();
  }  
}
void draw() {
  if (janela_atual == -1){
    janela_atual = int(random(num_janelas));
  }
  if (millis() - tempo > tempo_fechada && janelas[janela_atual].podeAbrir()){
    println("gerando aleatorio");
//    janelas[janela_atual] = janelas[janela_atual].exibe_aleatorio();
    janelas[janela_atual].exibe_aleatorio();
    janelas[janela_atual].trancaJanela();   
  }
  
  if (millis() - tempo > tempo_fechada + tempo_aberta){
//   janelas[janela_atual] = janelas[janela_atual].fecha_janela();
   janelas[janela_atual].fecha_janela();
   tempo = millis();
   janela_atual = -1; 
   println("resetou tempo e janela");
  }
}

void mousePressed() {
//  janela.click();
//  janela = janela.fecha_janela();
//  tempo = millis();
}
