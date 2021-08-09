#pragma once

#include "viewport.hxx"

#include <chrono>
#include <random>
#include <memory>
#include <vector>
#include <functional>


namespace ui {
	class mainwindow;
};
class ui::mainwindow {
	#pragma region aliases {
		public:
			typedef float float_t;
			typedef worm::viewport viewport_t;
	#pragma endregion aliases }
	#pragma region variables {
		public:
			viewport_t m_viewport;
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