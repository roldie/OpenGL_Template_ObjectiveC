//
//  ViewController.h
//  openGL_Template
//
//  Created by Harold Serrano on 4/26/14.
//  Copyright (c) 2014 Roldie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ViewController : GLKViewController{

    GLuint programObject;
    GLuint vertexArrayObject;
    GLuint vertexBufferObject;
    
    GLint modelViewProjectionUniformLocation;
    GLint normalMatrixUniformLocation;
    
    float aspect;
    GLKMatrix4 projectionMatrix;
    
    GLKMatrix4 cameraViewMatrix;
    GLKMatrix4 modelWorldMatrix;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix4 modelViewProjectionMatrix;
    GLKMatrix3 normalMatrix;
}

@property (strong, nonatomic) EAGLContext *context;

- (void)setupGL;
- (void)tearDownGL;
- (void)loadShaders;
- (void)setTransformations;


@end
