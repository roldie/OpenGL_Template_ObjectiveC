//
//  Shader.fsh
//  openGL_Template
//
//  Created by Harold Serrano on 4/26/14.
//  Copyright (c) 2014 Roldie. All rights reserved.
//

varying lowp vec4 colorVarying;


void main()
{
    gl_FragColor = colorVarying;
    
}
