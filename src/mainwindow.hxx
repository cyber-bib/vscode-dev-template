#pragma once

#include "viewport.hxx"

#include <chrono>
#include <random>
#include <memory>
#include <vector>
#include <functional>

namespace MFSim {
	class ToolPath;
};
class MFSim::ToolPath {
	#pragma region aliases {
		public:

	#pragma region aliases }

};

namespace worm {
	class mainwindow;
};
class worm::mainwindow {
	#pragma region aliases {
		public:
			typedef float float_t;
			typedef worm::viewport viewport_t;
			typedef PocketNC machine_t;	

			typedef GTPGenerator<float_t> path_generator_t;
			typedef path_generator_t::data_t path_data_t;

			typedef std::vector<vtkSmartPointer<vtkActor>> actor_vec_t;
	#pragma endregion aliases }
	#pragma region variables {
		public:
			viewport_t m_viewport;
			machine_t m_machine;	

			std::shared_ptr<path_data_t> m_toolpath;
			path_generator_t m_pathgenerator;

			actor_vec_t m_tp_actors;

	#pragma endregion variables }
	#pragma region initializers {
		public:
			mainwindow();
	#pragma endregion initializers }
	#pragma region peripheries {
		public:
			void start();
	#pragma endregion peripheries }
};

namespace temp {
	
};