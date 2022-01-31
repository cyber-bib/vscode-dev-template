#include "mainwindow.hxx"

#pragma region mainwindow-implementation {
	ui::mainwindow::mainwindow() {

		viewport_t::camera_t
		camera = m_viewport.getCamera();

		camera->SetPosition(-50.0, 50.0, 50.0);
		camera->SetFocalPoint(0, 0, 0);
		camera->SetViewUp(0.0, 1.0, 0.0);

	}
	void ui::mainwindow::start() {
		m_viewport.start();	
	}
#pragma region mainwindow-implementation }
