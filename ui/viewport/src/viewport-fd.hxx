#pragma once

#include <emscripten.h>
#include <GLES3/gl3.h>
#include <EGL/egl.h>

#include <vtkProperty.h>
#include <vtkSmartPointer.h>

#include <vtkActor.h>
#include <vtkCamera.h>
#include <vtkRenderer.h>
#include <vtkSDL2OpenGLRenderWindow.h>											// #include <vtkRenderWindow.h>
#include <vtkSDL2RenderWindowInteractor.h>										// #include <vtkRenderWindowInteractor.h>
#include <vtkInteractorStyleTrackballCamera.h>
#include <vtkCallbackCommand.h>
// #include <vtkObjectFactory.h>

#include <vtkAxesActor.h>
#include <vtkOrientationMarkerWidget.h>

// #include <vtkCylinderSource.h>
#include <vtkPolyDataMapper.h>

#include <vtkConeSource.h>
#include <vtkNew.h>

#include <vtkActor.h>
#include <vtkNamedColors.h>
#include <vtkPolyData.h>
#include <vtkPolyDataMapper.h>
#include <vtkProperty.h>
#include <vtkRenderWindow.h>
#include <vtkRenderWindowInteractor.h>
#include <vtkRenderer.h>




#include <array>
#include <iostream>

namespace em {
	class viewport;
	class custom_interactor_style;
	void window_modified_callback (
		vtkObject* caller,
		long unsigned int vtkNotUsed(eventId),
		void* vtkNotUsed(clientData),
		void* vtkNotUsed(callData)
	);
};