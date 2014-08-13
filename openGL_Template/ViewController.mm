//
//  ViewController.m
//  openGL_Template
//
//  Created by Harold Serrano on 4/26/14.
//  Copyright (c) 2014 Roldie. All rights reserved.
//

#import "ViewController.h"
#include <vector>
#include "lodepng.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))
using namespace std;
GLfloat cubeVertexData[192] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.00000, 1.00000, 0.00000, 0.00000, 1.00000, -0.50000, -0.50000, 0.50000,
    0.00000, 0.00000, 0.00000, 0.00000, 1.00000, -0.50000, 0.50000, 0.50000,
    1.00000, 0.00000, 0.00000, 0.00000, 1.00000, 0.50000, 0.50000, 0.50000,
    1.00000, 1.00000, 0.00000, 0.00000, 1.00000, 0.50000, -0.50000, 0.50000,
    0.00000, 1.00000, 0.00000, 0.00000, -1.00000, 0.50000, -0.50000, -0.50000,
    0.00000, 0.00000, 0.00000, 0.00000, -1.00000, 0.50000, 0.50000, -0.50000,
    1.00000, 0.00000, 0.00000, 0.00000, -1.00000, -0.50000, 0.50000, -0.50000,
    1.00000, 1.00000, 0.00000, 0.00000, -1.00000, -0.50000, -0.50000, -0.50000,
    0.00000, 1.00000, -1.00000, 0.00000, 0.00000, -0.50000, -0.50000, -0.50000,
    0.00000, 0.00000, -1.00000, 0.00000, 0.00000, -0.50000, 0.50000, -0.50000,
    1.00000, 0.00000, -1.00000, 0.00000, 0.00000, -0.50000, 0.50000, 0.50000,
    1.00000, 1.00000, -1.00000, 0.00000, 0.00000, -0.50000, -0.50000, 0.50000,
    0.00000, 1.00000, 1.00000, 0.00000, 0.00000, 0.50000, -0.50000, 0.50000,
    0.00000, 0.00000, 1.00000, 0.00000, 0.00000, 0.50000, 0.50000, 0.50000,
    1.00000, 0.00000, 1.00000, 0.00000, 0.00000, 0.50000, 0.50000, -0.50000,
    1.00000, 1.00000, 1.00000, 0.00000, 0.00000, 0.50000, -0.50000, -0.50000,
    0.00000, 1.00000, 0.00000, 1.00000, 0.00000, -0.50000, 0.50000, 0.50000,
    0.00000, 0.00000, 0.00000, 1.00000, 0.00000, -0.50000, 0.50000, -0.50000,
    1.00000, 0.00000, 0.00000, 1.00000, 0.00000, 0.50000, 0.50000, -0.50000,
    1.00000, 1.00000, 0.00000, 1.00000, 0.00000, 0.50000, 0.50000, 0.50000,
    0.00000, 1.00000, 0.00000, -1.00000, 0.00000, -0.50000, -0.50000, -0.50000,
    0.00000, 0.00000, 0.00000, -1.00000, 0.00000, -0.50000, -0.50000, 0.50000,
    1.00000, 0.00000, 0.00000, -1.00000, 0.00000, 0.50000, -0.50000, 0.50000,
    1.00000, 1.00000, 0.00000, -1.00000, 0.00000, 0.50000, -0.50000, -0.50000
};

int Box_index[36]={
    0, 1, 2,
    2, 3, 0,
    4, 5, 6,
    6, 7, 4,
    8, 9, 10,
    10, 11, 8,
    12, 13, 14,
    14, 15, 12,
    16, 17, 18,
    18, 19, 16,
    20, 21, 22,
    22, 23, 20
};

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    //Setup the OpenGL Context
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;

    view.enableSetNeedsDisplay=60.0;
    [EAGLContext setCurrentContext:self.context];
    
    //Setup the OpenGL
    [self setupGL];
}



- (void)setupGL
{
    
    [self loadShaders];
    
    
    glEnable(GL_DEPTH_TEST);
    
    //1. Generate a Vertex Array Object
    
    glGenVertexArraysOES(1,&vertexArrayObject);
    
    //2. Bind the Vertex Array Object
    
    glBindVertexArrayOES(vertexArrayObject);
    
    //3. Generate a Vertex Buffer Object
    
    glGenBuffers(1, &vertexBufferObject);
    
    //4. Bind the Vertex Buffer Object
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
    
    //5. Dump the date into the Buffer
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertexData), cubeVertexData, GL_STATIC_DRAW);
    
    //6. Get the location of the shader attribute called "position"
    
    GLuint positionLocation=glGetAttribLocation(programObject, "position");
    
    //7. Get the location of the shader attribute called "normal"
    
    GLuint normalLocation=glGetAttribLocation(programObject, "normal");
    
    GLuint texLocation=glGetAttribLocation(programObject, "texture");
    
    //8. Enable both locations
    
    glEnableVertexAttribArray(positionLocation);
    
    glEnableVertexAttribArray(normalLocation);
    
    glEnableVertexAttribArray(texLocation);
    
    
    
    //9. Link the buffer data to the shader attribute locations
    
    glVertexAttribPointer(positionLocation, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(20));
    glVertexAttribPointer(normalLocation, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(8));
    glVertexAttribPointer(texLocation, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
    
    //11. Get Location of uniforms
    modelViewProjectionUniformLocation = glGetUniformLocation(programObject, "modelViewProjectionMatrix");
    normalMatrixUniformLocation = glGetUniformLocation(programObject, "normalMatrix");
    textureUniformLocation=glGetUniformLocation(programObject, "Tex");
    
    
    glActiveTexture(GL_TEXTURE0);
    glGenTextures(1, &textureID[0]);
    glBindTexture(GL_TEXTURE_2D, textureID[0]);
    [self loadTexture];
    //10. Unbind the Vertex Array Object
    glBindVertexArrayOES(0);
    
    [self setTransformations];
    
}

- (void)setTransformations{
    
    //1. set the aspect viewing ratio of your device
    aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    
    //2. set the projection matrix
    projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    //3. set the camera matrix
    cameraViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    
    //4. move the Model-World matrix 1.5 into the z-axis
    modelWorldMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 1.5f);
    
    //5. rotate the Model-World matrix
    modelWorldMatrix = GLKMatrix4Rotate(modelWorldMatrix, 30.0, 1.0f, 1.0f, 1.0f);
    
    //6. transform the Model-World matrix into the Model-View matrix
    modelViewMatrix = GLKMatrix4Multiply(cameraViewMatrix, modelWorldMatrix);
    
    //7. extract the 3x3 normal matrix from the Model-View matrix for shading(light) purposes
    normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    //8. set the MVP matrix
    modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    //get the uniform locations of both the MVP and normal matrix
    glUniformMatrix4fv(modelViewProjectionUniformLocation, 1, 0, modelViewProjectionMatrix.m);
    glUniformMatrix3fv(normalMatrixUniformLocation, 1, 0, normalMatrix.m);
    
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
   //UPDATE HERE
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
    glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindVertexArrayOES(vertexArrayObject);
    
    glUseProgram(programObject);
    
   glActiveTexture(GL_TEXTURE0);
   glBindTexture(GL_TEXTURE_2D, textureID[0]);
   glUniform1i(textureUniformLocation, 0);
    
    glDrawElements(GL_TRIANGLES,36,GL_UNSIGNED_INT,Box_index);
    
    glBindVertexArrayOES(0);
}

#pragma mark -  OpenGL ES 2 shader compilation

-(void)loadTexture{

    // Load file and decode image.
    vector<unsigned char> image;
    unsigned int width, height;
    
    unsigned error = lodepng::decode(image, width, height,"Plywood.png");
    
    //if there's an error, display it
    if(error){
        NSLog(@"Error loading image");
    }else{
        
        //Flip and invert the image
        unsigned char* imagePtr=&image[0];
        
        int halfTheHeightInPixels=height/2;
        int heightInPixels=height;
        
        
        //Assume RGBA for 4 components per pixel
        int numColorComponents=4;
        
        //Assuming each color component is an unsigned char
        int widthInChars=width*numColorComponents;
        
        unsigned char *top=NULL;
        unsigned char *bottom=NULL;
        unsigned char temp=0;
        
        for( int h = 0; h < halfTheHeightInPixels; ++h )
        {
            top = imagePtr + h * widthInChars;
            bottom = imagePtr + (heightInPixels - h - 1) * widthInChars;
            
            for( int w = 0; w < widthInChars; ++w )
            {
                // Swap the chars around.
                temp = *top;
                *top = *bottom;
                *bottom = temp;
                
                ++top;
                ++bottom;
            }
        }
        
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_LINEAR);
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_REPEAT);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0,
                     GL_RGBA, GL_UNSIGNED_BYTE, &image[0]);
        
    }
    
}


-(void)loadShaders{

    //1. Create the shader objects
    
    GLuint vertexShaderObject=glCreateShader(GL_VERTEX_SHADER);
    GLuint fragmentShaderObject=glCreateShader(GL_FRAGMENT_SHADER);
    
    //2. Get the path for each shader source
    NSString *vertexCodePathname=[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    NSString *fragmentCodePathname=[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    
    const GLchar *vertexCodeSource=(GLchar *)[[NSString stringWithContentsOfFile:vertexCodePathname encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    //3. Check if the vertex and fragment were successfully loaded
    if (!vertexCodeSource) {
        NSLog(@"Failed to load vertex shader");
    }else{
        NSLog(@"vertex shader loaded successfully");
    }
    
    const GLchar *fragmentCodeSource=(GLchar *)[[NSString stringWithContentsOfFile:fragmentCodePathname encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    if (!fragmentCodeSource) {
        NSLog(@"Failed to load vertex shader");
    }else{
        NSLog(@"fragment shader loaded successfully");
    }
    
    //4. Provide source code for each object
    glShaderSource(vertexShaderObject, 1, &vertexCodeSource, NULL);
    glShaderSource(fragmentShaderObject, 1, &fragmentCodeSource, NULL);
    
    //5. Compile the shader objects
    
    glCompileShader(vertexShaderObject);
    
    //6. Check if the compilation was a success
    GLint result;
    glGetShaderiv(vertexShaderObject, GL_COMPILE_STATUS, &result);
    if (result==GL_FALSE) {
        
        NSLog(@"Vertex shader compilation failed");
    }else{

        NSLog(@"Vertex shader compilaton was a success");
    }
    
    glCompileShader(fragmentShaderObject);
    
    glGetShaderiv(fragmentShaderObject, GL_COMPILE_STATUS, &result);
    if (result==GL_FALSE) {
        
        NSLog(@"Fragment shader compilation failed");
    }else{
        
        NSLog(@"Fragment shader compilaton was a success");
    }
    
    //7. Create the program object
    
    programObject=glCreateProgram();
    
    //8. Attach the shaders to the program
    
    glAttachShader(programObject, vertexShaderObject);
    glAttachShader(programObject, fragmentShaderObject);
    
    //9. Link the program
    
    glLinkProgram(programObject);
    
    //10. check if the link was successful
    GLint status;
    
    glGetProgramiv(programObject, GL_LINK_STATUS, &status);
    
    if (status==GL_FALSE) {
        
        NSLog(@"The link failed");
    }else{
     
        //if the link was successful, then use the program
        
        NSLog(@"The link was a success");
        
        //11. use the program
        
        glUseProgram(programObject);
    }
    
}


- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        //[self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    // Dispose of any resources that can be recreated.
}


- (void)tearDownGL{
 
 [EAGLContext setCurrentContext:self.context];
 
 glDeleteBuffers(1, &vertexBufferObject);
 glDeleteVertexArraysOES(1, &vertexArrayObject);
 
 
 if (programObject) {
 glDeleteProgram(programObject);
 programObject = 0;
     
 }
 
}

@end
