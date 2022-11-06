Circle circle1;

int numCircles = 30;
int initialSpeed = 3;
Circle[] circles = new Circle[numCircles]; // define the array
PShader bwShader, edgesShader, lightShader;
PeasyGradients peasyGradients;

void setup() {
    size(1350, 900, P2D);
    PeasyGradients peasyGradients = new PeasyGradients(this);
    for (int i = 0; i < numCircles; i++) {    
        circles[i] = generateRandomCircle(i,0,peasyGradients);
    }    
    //bwShader.
    bwShader = loadShader("blur.glsl");
    edgesShader = loadShader("eye.glsl");
    lightShader = loadShader("textlightfrag.glsl", "textlightvert.glsl");
}

void draw() {
    bwShader.set("sigma", 3.15);
    bwShader.set("blurSize",3);
    // bwShader.set("texOffset", 1.0, 1.0);
    // shader(edgesShader);
    // shader(lightShader);
    
    background(0, 0, 0);
    // pointLight(255, 255, 255, width / 2, height, 200);
    for (int i = 0; i < numCircles; i++) {
        circles[i].update().draw();
    }
    shader(bwShader);
    
    //tint(255,255,0);    
}

void keyPressed() {
    //if (keyCode == UP    && y - rad >= 0    )  y -= speed;
    //if (keyCode == DOWN  && y + rad <= height)  y += speed;
    //if (keyCode == LEFT  && x - rad >= 0 && speed / 2 > 1 ) speed = speed / 2;
    //if (keyCode == RIGHT && x + rad <= width)  speed = speed * 2;
}
