
class Circle{
    public PeasyGradients peasyGradients;
    public Point center;
    PGraphics ellipse, ellipseMask;
    int rad;
    int xDirection = random( -1,1) > 0 ? 1 : - 1;
    int yDirection = random( -1,1) > 0 ? 1 : - 1;
    int speed = initialSpeed;
    
    // constructor
    Circle(Point cp,int radius,PeasyGradients p) {
        center = cp;
        rad = radius;
        peasyGradients = p;
        
        this.setup();
    }
    
    void updateDirectionCollideWith(Circle otherCircle) {
        Point other = otherCircle.center;
        float distanceBetweenCircles = this.rad + otherCircle.rad;   
        boolean isColliding = isColliding(this,otherCircle);
        
        if (isColliding) {
            // isHorizontalColliding
            if (abs(center.x - other.x) < distanceBetweenCircles) {
                //print("horizontal collide \n");
                if (center.x - other.x > 0) {
                    xDirection = 1;
                    otherCircle.xDirection = -1;
                    // speed ++;
                } else{
                    xDirection = -1;
                    otherCircle.xDirection = 1;
                    // otherCircle.speed -= 1;
                }
            }
            
            if (abs(center.y - other.y) < distanceBetweenCircles) {
                //print("vertical collide \n");
                if (center.y - other.y > 0) {
                    yDirection = 1;
                    otherCircle.yDirection = -1;
                } else{
                    yDirection =-  1;
                    otherCircle.yDirection = 1;
                }
            }
        }
    }
    
    
    Circle update() {
        
        for (Circle circle : circles) {
            if (circle != this) {
                updateDirectionCollideWith(circle);
            }
        }
        
        if (center.x + rad * 2 > width || center.x < 0) {
            xDirection = -xDirection;
        }
        if (center.y + rad * 2 > height || center.y < 0) {
            yDirection = -yDirection;
        }
        
        return this;
    }
    
    void setup() {
        int diameter = rad * 2;
        int r = floor(100 + random(105)),g = floor(100 + random(105)),b = floor(100 + random(105));
        
        Gradient pinkToYellow = new Gradient(color(255),color(r + 25, g + 25, b + 25), color(r, g, b), color(r - 50,g - 50,b - 50), color(0));
        ellipse = createGraphics(diameter, diameter);
        peasyGradients.setRenderTarget(ellipse);
        peasyGradients.radialGradient(pinkToYellow, new PVector(rad , rad), 0.5);
        ellipseMask = createGraphics(diameter, diameter);
        ellipseMask.beginDraw();
        ellipseMask.fill(255); // keep white pixels
        ellipseMask.circle(rad, rad,diameter);
        ellipseMask.endDraw();
        ellipse.mask(ellipseMask);
    }
    
    void draw() {
        
        // blendMode(SCREEN);
        // shader(bwShader);
        
        
        image(ellipse,center.x , center.y,rad * 2,rad * 2);
        // fill(r,g,b);
        
        
        center.x += speed * xDirection;
        center.y += speed * yDirection;
    }
}
