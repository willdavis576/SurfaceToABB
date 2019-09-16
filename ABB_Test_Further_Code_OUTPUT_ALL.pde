/*
Code written by Will Davis, 2019.

****** Using the code ******
 - Run the code
 - Use a mouse or interactive pen to draw a picture on the window
 - Pressed the 's' button to save to a .mod and a .txt file
 - Copy the generated RAPID code into the RAPID tab on RobotStudio
 - Apply and run the simulation.
 **/

float x;
float y;
float easing = 1;
float[] dataX = new float[10000];
float[] dataY = new float[10000];
float[] dataZ = new float[10000];
Table table;
String output; 
int counter = 1;
boolean capture = false;
boolean done1 = false;
boolean mouseAway = true;
String[] name = new String[10000];



void setup() {
  size(350, 350); 
  background(51);
  noStroke();
}

void draw() { 
  //background(51);
  float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing;

  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;

  if ( capture == true) {
    ellipse(x, y, 10, 10);
    dataX[counter] = mouseX + 50;
    dataY[counter] = -mouseY + 400;
    dataZ[counter] = 0;
    name[counter] = " Extended_Project_Drawing_" + str(counter * 10);
    delay(10);
    counter += 1;
  }

  if (mouseAway == true) {
    dataX[counter] = dataX[counter - 1];
    dataY[counter] = dataY[counter - 1];
    dataZ[counter] = dataZ[counter - 1] + 100;
    name[counter] = " Extended_Project_Drawing_" + str(counter * 10);
    counter += 1;
    mouseAway = false;
  }

  println(counter);
}

void mousePressed() { 
  capture = true;
  mouseAway = false;
}

void mouseReleased() {
  capture = false;
  mouseAway = true;
}

void keyPressed() {
  if (key == 't') {
    println("Keys are working");
  }
  if (key == 's') {
    saveTableProc();
  }
}

void saveTableProc() {
  String[] instructions = new String[((counter) * 2) + 5];
  if (done1 == false) {
    for (int i = 0; i < counter; i++) {
      instructions[i] = "CONST robtarget" + name[i] + ":=[[" +  str(dataX[i]) + "," + str(dataY[i]) + "," + str(dataZ[i]) + "],[0.00092307,-0.000001319,-0.999998553,0.001428798],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];";
      if (counter == i) {
        done1 = true;
      }
    }
    for (int j = counter + 4; j < counter*2 + 3; j++) {
      instructions[j] = "MoveL" + name[j - counter- 3] + ",v1000,z100,PenTool\\WObj:=Drawing_table;";
    }
    instructions[counter] = "PROC main()";
    instructions[counter + 1] = "    drawShape;";
    instructions[counter + 2] = "ENDPROC";
    instructions[counter + 3] = "PROC drawShape()";
    instructions[0] = "MODULE Module1";
    instructions[counter*2+3] = "  ENDPROC";
    instructions[counter*2+4] = "ENDMODULE";
    saveStrings("Module1.txt", instructions);
    saveStrings("Module1.mod", instructions);
   
    done1 = true;
    println(done1);
  }
}
