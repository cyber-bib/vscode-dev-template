#pragma once

#include "viewport-fd.hxx"

class em::viewport {
    #pragma region typedefs {
        public:
            typedef vtkSmartPointer<vtkSDL2OpenGLRenderWindow> window_t;	
            typedef vtkSmartPointer<vtkSDL2RenderWindowInteractor> interactor_t;
            typedef vtkSmartPointer<vtkInteractorStyleTrackballCamera> style_t;
            typedef vtkSmartPointer<vtkRenderer> renderer_t;	
            typedef vtkSmartPointer<vtkCamera> camera_t;
            typedef vtkSmartPointer<vtkAxesActor> axes_t;
            typedef vtkSmartPointer<vtkOrientationMarkerWidget> axesWidget_t;

            typedef vtkSmartPointer<vtkActor> actor_t;
			typedef vtkSmartPointer<vtkCallbackCommand> callback_t;
    #pragma endregion } typedefs 
    #pragma region variables {
        private:
            window_t m_window;	
            interactor_t m_interactor;	
            style_t m_style;
            renderer_t m_renderer;	
            camera_t m_camera;	
            axes_t m_axes;
            axesWidget_t m_axesWidget;
			callback_t m_modified_cb;
    #pragma endregion } variables 
    #pragma region initializers {
        public:
            viewport(const char* title = "vtk viewport");
    #pragma endregion } initializers 
    #pragma region getters {
        public:
            camera_t getCamera();
            renderer_t getRenderer();
    #pragma endregion } getters
    #pragma region peripheries {
        public:
            void start();
            void add(actor_t actor);
            void remove(actor_t actor);
    #pragma endregion } peripheries
};