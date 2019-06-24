/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// OpenGL ES 2.0 code

#include <jni.h>
#include <android/log.h>

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>
#include "glm/gtc/matrix_transform.hpp"

unsigned int Ltexture, otexture;

void mkLtexture(void) {
    int tw, th, i, k;
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    glGenTextures(1, &Ltexture);
    glBindTexture(GL_TEXTURE_2D, Ltexture);
    tw=32;
    th=64;
    uint8_t buffer[tw*th];
    for (i=0; i<tw;i++)
        for (k=0; k<th;k++)
            if (i<3||k<3)
                buffer[k*tw+i]=0xFF; else buffer[k*tw+i]=0;
    glTexImage2D(
            GL_TEXTURE_2D,
            0,
            GL_ALPHA,
            tw,
            th,
            0,
            GL_ALPHA,
            GL_UNSIGNED_BYTE,
            buffer
    );
    // Set texture options
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S,  GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T,  GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

}

void mkotexture(void) {
    int tw, th, i, k;
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    glGenTextures(1, &otexture);
    glBindTexture(GL_TEXTURE_2D, otexture);
    tw=32;
    th=32;
    uint8_t buffer[tw*th];
    for (i=0; i<tw;i++)
        for (k=0; k<th;k++)
            if (i<3||k<3|| tw-i<=3||th-k<=3)
                buffer[k*tw+i]=0xFF; else buffer[k*tw+i]=0;
    glTexImage2D(
            GL_TEXTURE_2D,
            0,
            GL_ALPHA,
            tw,
            th,
            0,
            GL_ALPHA,
            GL_UNSIGNED_BYTE,
            buffer
    );


    // Set texture options
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S,  GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T,  GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

}

int h_pkfont(char *filename)
{ mkLtexture();
    mkotexture();
    return 0;
}

unsigned int h_glyph(int f, unsigned int c)
{ if ('A'<= c && c <='Z')
        return Ltexture;
    else
        return otexture;
}



#define  LOG_TAG    "libgl2jni"
#define  LOGI(...)  __android_log_print(ANDROID_LOG_INFO,LOG_TAG,__VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

static void printGLString(const char *name, GLenum s) {
    const char *v = (const char *) glGetString(s);
    LOGI("GL %s = %s\n", name, v);
}

static void checkGlError(const char* op) {
    for (GLint error = glGetError(); error; error
            = glGetError()) {
        LOGI("after %s() glError (0x%x)\n", op, error);
    }
}

auto gVertexShader =
        "#version 100\n"
    "attribute vec4 vPosition;\n"
    "varying vec2 TexCoord;\n"
    "uniform mat4 projection;\n"
    "void main() {\n"
    "  gl_Position = projection*vec4(vPosition.x,vPosition.y,1.0,1.0);\n"
    "  TexCoord=vec2(vPosition.z,vPosition.w);\n"
    "}\n";

auto gFragmentShader =
    "precision mediump float;\n"
    "varying vec2 TexCoord;\n"
    "uniform sampler2D ourTexture;\n"
    "uniform vec4 ourColor;\n"
    "void main() {\n"
    "  gl_FragColor = vec4(ourColor.x,ourColor.y,ourColor.z, texture2D(ourTexture,TexCoord).w);\n"
"}\n";

GLuint loadShader(GLenum shaderType, const char* pSource) {
    GLuint shader = glCreateShader(shaderType);
    if (shader) {
        glShaderSource(shader, 1, &pSource, NULL);
        glCompileShader(shader);
        GLint compiled = 0;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);
        if (!compiled) {
            GLint infoLen = 0;
            glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &infoLen);
            if (infoLen) {
                char* buf = (char*) malloc(infoLen);
                if (buf) {
                    glGetShaderInfoLog(shader, infoLen, NULL, buf);
                    LOGE("Could not compile shader %d:\n%s\n",
                            shaderType, buf);
                    free(buf);
                }
                glDeleteShader(shader);
                shader = 0;
            }
        }
    }
    return shader;
}

GLuint createProgram(const char* pVertexSource, const char* pFragmentSource) {
    GLuint vertexShader = loadShader(GL_VERTEX_SHADER, pVertexSource);
    if (!vertexShader) {
        return 0;
    }

    GLuint pixelShader = loadShader(GL_FRAGMENT_SHADER, pFragmentSource);
    if (!pixelShader) {
        return 0;
    }

    GLuint program = glCreateProgram();
    if (program) {
        glAttachShader(program, vertexShader);
        checkGlError("glAttachShader");
        glAttachShader(program, pixelShader);
        checkGlError("glAttachShader");
        glLinkProgram(program);
        GLint linkStatus = GL_FALSE;
        glGetProgramiv(program, GL_LINK_STATUS, &linkStatus);
        if (linkStatus != GL_TRUE) {
            GLint bufLength = 0;
            glGetProgramiv(program, GL_INFO_LOG_LENGTH, &bufLength);
            if (bufLength) {
                char* buf = (char*) malloc(bufLength);
                if (buf) {
                    glGetProgramInfoLog(program, bufLength, NULL, buf);
                    LOGE("Could not link program:\n%s\n", buf);
                    free(buf);
                }
            }
            glDeleteProgram(program);
            program = 0;
        }
    }
    return program;
}

GLuint gProgram;
GLuint gvPositionHandle;

GLfloat hsize, vsize; // Size of canvas in point
GLfloat dpi=300; // resolution of canvas
// converting pixel to pointe and back
#define px2pt(X)   (72.27f*(X)/dpi)
#define pt2px(T)   ((T)*dpi/72.27f)


bool resizeGraphics(void) {

    LOGI("resizeGraphics(%f pt, %f pt)", hsize, vsize);

    int ourProjectionLocation = glGetUniformLocation(gProgram, "projection");
    glUseProgram(gProgram);
    // Coordinates are in points
    glm::mat4 projection = glm::ortho(0.0f, (float)hsize, 0.0f, (float)vsize);
    glUniformMatrix4fv(ourProjectionLocation,1,0,glm::value_ptr(projection));

    glViewport(0,0,(GLsizei)pt2px(hsize),(GLsizei)pt2px(vsize));
    LOGE("End of resize.");
    return true;
}



bool setupGraphics(void) {

    printGLString("Version", GL_VERSION);
    printGLString("Vendor", GL_VENDOR);
    printGLString("Renderer", GL_RENDERER);
    printGLString("Extensions", GL_EXTENSIONS);


    LOGI("setupGraphics(%f pt, %f pt)", hsize, vsize);
    gProgram = createProgram(gVertexShader, gFragmentShader);
    if (!gProgram) {
        LOGE("Could not create program.");
        return false;
    }
    gvPositionHandle = glGetAttribLocation(gProgram, "vPosition");
    checkGlError("glGetAttribLocation");
    LOGI("glGetAttribLocation(\"vPosition\") = %d\n", gvPositionHandle);
    glEnableVertexAttribArray(gvPositionHandle);
    checkGlError("glEnableVertexAttribArray");

    int ourColorLocation = glGetUniformLocation(gProgram, "ourColor");
    int ourProjectionLocation = glGetUniformLocation(gProgram, "projection");
    glUseProgram(gProgram);
    // Text Color
    glUniform4f(ourColorLocation, 0.0f, 0.0f, 0.5f, 0.0f);

    h_pkfont(NULL);

    // Coordinates are in points
    glm::mat4 projection = glm::ortho(0.0f, (float)hsize, 0.0f, (float)vsize);
    glUniformMatrix4fv(ourProjectionLocation,1,0,glm::value_ptr(projection));

    glViewport(0,0,(GLsizei)pt2px(hsize),(GLsizei)pt2px(vsize));
       LOGE("End of init.");
    return true;
}






void renderChar(float x, float y, float w, float h,GLuint glyph)
{    GLfloat gQuad[] = { x , y,        0.0f,0.0f,
                         x, y+h,       0.0f,1.0f,
                         x+w, y+h,     1.0f,1.0f,
                         x, y,         0.0f,0.0f,
                         x+w, y+h,     1.0f,1.0f,
                         x+w,y,        1.0f,0.0f
    };
    glBindTexture(GL_TEXTURE_2D, glyph);

    glVertexAttribPointer(gvPositionHandle, 4, GL_FLOAT, GL_FALSE, 4*sizeof(float), gQuad);
    checkGlError("glVertexAttribPointer");
    glDrawArrays(GL_TRIANGLES, 0, 6);
    checkGlError("glDrawArrays");
}
//std::unique_ptr<GLubyte[]> pixel;

void renderFrame(void) {
    float x,y;
 //   LOGI("Render Frame ");
    glClearColor(1.0f, 1.0f, 0.75f, 1.0f);
    //checkGlError("glClearColor");
    glClear( GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    //checkGlError("glClear");
    glEnable(GL_BLEND);
     //checkGlError("glEnable BLEND");
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    //checkGlError("glBlendFunc");

    int ourProjectionLocation = glGetUniformLocation(gProgram, "projection");
    glm::mat4 projection = glm::ortho(0.0f, (float)hsize, 0.0f, (float)vsize);
    glUniformMatrix4fv(ourProjectionLocation,1,0,glm::value_ptr(projection));

    for ( y=vsize-24.0; y> 12.0; y=y-12.0)
    {
        for (x=12.0; x < hsize-12.0; x=x+6.0)
            if (x<=12.0)
                renderChar(x,y,5.0,10.0,h_glyph(0,'L'));
            else
                renderChar(x,y,5.0,5.0,h_glyph(0,'o'));
    }

}

extern "C" {
    JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_init(JNIEnv * env, jobject obj,  jint width, jint height);
   // JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_resize(JNIEnv * env, jobject obj,  jint width, jint height);
    JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_step(JNIEnv * env, jobject obj,  jint width, jint height);
};

JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_init(JNIEnv * env, jobject obj,  jint width, jint height)
{
     LOGI("setupGraphics(%d px, %d px)", width, height);
    hsize=px2pt((float)width);
    vsize=px2pt((float)height);


    setupGraphics();
}

/*
JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_resize(JNIEnv * env, jobject obj,  jint width, jint height)
{
     LOGI("resizeGraphics(%d px, %d px)", width, height);
    hsize=px2pt((float)width);
    vsize=px2pt((float)height);


    resizeGraphics();
    renderFrame();
}
*/

JNIEXPORT void JNICALL Java_com_yourcompany_opengltexture_GL2JNILib_step(JNIEnv * env, jobject obj,  jint width, jint height)
{    hsize=px2pt((float)width);
     vsize=px2pt((float)height);
     renderFrame();
}
