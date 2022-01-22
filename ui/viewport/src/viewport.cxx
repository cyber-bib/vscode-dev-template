#include "viewport.hxx"

#pragma region window_modified_callback {
	void em::window_modified_callback (
		vtkObject* caller,
		long unsigned int vtkNotUsed(eventId),
		void* vtkNotUsed(clientData),
		void* vtkNotUsed(callData)
	) {
		int width, height, cwidth, cheight;
		
		width = EM_ASM_INT({
			return Module.updateWidth();
		});
		height = EM_ASM_INT({
			return Module.updateHeight();
		});
		// EM_ASM({	
		// 	console.log(
		// 		Math.floor(0.99 * window.innerWidth - 4),
		// 		Math.floor(0.99 * window.innerHeight - 4),
		// 	);
		// });
		// std::cout << "width: " << width << ", height: "<< height << std::endl;

		vtkSDL2OpenGLRenderWindow* window = static_cast<vtkSDL2OpenGLRenderWindow*>(caller);
		int* windowSize = window->GetSize();

		std::tie(cwidth, cheight) = std::forward_as_tuple(window->GetSize()[0], window->GetSize()[1]);
		if(cwidth != width || cheight != height) {
			window->SetSize(width, height);
			window->Render();
		}
	}
#pragma endregion } window_modified_callback
#pragma region viewport {
	#pragma region [con/de]structors {
		em::viewport::viewport (
			const char* title
		) {

			m_renderer = renderer_t::New();
			m_renderer->SetBackground(0.5, 0.5, 0.5);
			m_renderer->ResetCamera();

			m_camera = m_renderer->GetActiveCamera();
			m_camera->Zoom(1.5);

			m_modified_cb = callback_t::New();
			m_modified_cb->SetCallback(em::window_modified_callback);
			m_modified_cb->SetClientData(this);

			m_window = window_t::New();
			m_window->SetSize(500, 500);
			m_window->AddRenderer(m_renderer);
			m_window->SetWindowName("vtk viewport");
			m_window->AddObserver(vtkCommand::ModifiedEvent, m_modified_cb);
			// vtkCommand::UserEvent
			// vtkSmartPointer<vtkCallbackCommand> m_pModifiedCallback = vtkSmartPointer<vtkCallbackCommand>::New();
			// m_pModifiedCallback->SetCallback (em::window_modified_callback);
			// //m_pModifiedCallback->SetClientData(this);
			// m_window->AddObserver(vtkCommand::ModifiedEvent, m_pModifiedCallback);

			m_style = style_t::New();
			
			m_interactor = interactor_t::New();
			m_interactor->SetRenderWindow(m_window);
			m_interactor->SetInteractorStyle(m_style);
			
			m_axes = axes_t::New();
			m_axesWidget = axesWidget_t::New();
			m_axesWidget->SetOutlineColor(0.93, 0.57, 0.13);
			m_axesWidget->SetOrientationMarker(m_axes);
			m_axesWidget->SetInteractor(m_window->GetInteractor());
			m_axesWidget->SetViewport(0.0, 0.0, 0.25, 0.25);
			m_axesWidget->SetEnabled(1);
			m_axesWidget->InteractiveOn();

		}
	#pragma endregion } [con/de]structors 
	#pragma region getters {
		em::viewport::camera_t
		em::viewport::getCamera() {
			return m_camera;
		}
		em::viewport::renderer_t
		em::viewport::getRenderer () {
			return m_renderer;
		}
	#pragma endregion } getters 
	#pragma region peripheries {
		void
		em::viewport::start() {
			m_window->Render();
			m_interactor->Start();	

			// this never runs !!!
			std::cout << "ran after interactor start\n";

			m_camera = m_renderer->GetActiveCamera();
			m_camera->SetViewUp(0.0, 1.0, 0.0);
			m_camera->SetPosition(2.5, -2.5, 2.5);
			m_camera->SetPosition(0.0, 0.0, 0.0);
			m_camera->SetClippingRange(0.001, 4.0);
		}
		void
		em::viewport::add(actor_t actor) {
			m_renderer->AddActor(actor);
		}
		void
		em::viewport::remove(actor_t actor) {
			m_renderer->RemoveActor(actor);
		}
	#pragma endregion } peripheries
#pragma endregion } viewport
