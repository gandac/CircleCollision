
class Circle{
    public PeasyGradients peasyGradients;
    public PVector location;
    // Vector dir;
    PGraphics ellipse, ellipseMask;
    int rad;
    float xDirection = random( -1.00,1.00);
    float yDirection = random( -1.00,1.00);
    PVector velocity = new PVector(random( -initialSpeed, initialSpeed),random( -initialSpeed, initialSpeed));
    PVector acceleration = new PVector(0, 0);
    
    
    // constructor
    Circle(PVector lc,int radius,PeasyGradients p) {
        location = lc;
        rad = radius;
        peasyGradients = p;
        
        this.setup();
    }
    
    void checkCollisionWith(Circle otherCircle) {
        PVector other = otherCircle.location;
        float distanceBetweenCircles = this.rad + otherCircle.rad;   
        boolean isColliding = isColliding(this,otherCircle);
        
        if (isColliding) {
            // isHorizontalColliding
            if (abs(location.x - other.x) < distanceBetweenCircles) {
                //print("horizontal collide \n");
                if (location.x - other.x > 0) {
                    velocity.x = abs(velocity.x);
                    otherCircle.velocity.x = -abs(otherCircle.velocity.x);
                } else{
                    velocity.x = -abs(velocity.x);
                    otherCircle.velocity.x = abs(otherCircle.velocity.x);
                }
            }
            
            if (abs(location.y - other.y) < distanceBetweenCircles) {
                if (location.y - other.y > 0) {
                    velocity.y = abs(velocity.y);
                    otherCircle.velocity.y = -abs(otherCircle.velocity.y);
                } else{
                    velocity.y = -abs(velocity.y);
                    otherCircle.velocity.y = abs(otherCircle.velocity.y);
                }
            }
        }
    }
    
    void checkBoundaries() {
        if (location.x + rad * 2 > width || location.x < 0) {
            velocity.x = -velocity.x;
        }
        if (location.y + rad * 2 > height || location.y < 0) {
            velocity.y = -velocity.y;
        }
    }
    
    Circle update() {
        
        for (Circle circle : circles) {
            if (circle != this) {
                checkCollisionWith(circle);
            }
        }
        
        checkBoundaries();
        
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
        velocity.add(acceleration);
        velocity.limit(initialSpeed);
        location.add(velocity);
        
        image(ellipse,location.x , location.y,rad * 2,rad * 2);
        // fill(r,g,b);
        
    }
}
