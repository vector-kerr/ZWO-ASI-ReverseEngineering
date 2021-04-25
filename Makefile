
# CFLAGS   = -W -Wall -O3 -std=c99
# CXXFLAGS = -W -Wall -O3 -std=c++11

CFLAGS   = -W -Wall -std=c99
CXXFLAGS = -W -Wall -std=c++11
OPENCV = $(pkg-config --cflags --libs opencv2 opencv4)
DEFS = -D_LIN -D_DEBUG 

.PHONY : clean default

default : asi-test-ORIG asi-test asi-test-RE asi-test-c-compatibility test_gui2_snap

asi-test-ORIG : asi-test.o asi-enum-strings.o libASICamera2.a
	$(CXX) $^ libASICamera2.a -lusb-1.0 -lpthread -o $@

asi-test : asi-test.o libUSB.o asi-enum-strings.o libASICamera2_patched.a
	$(CXX) $^ -lusb-1.0 libASICamera2_patched.a -lpthread -o $@

asi-test-RE : asi-test.o libUSB.o libASICamera2_ReverseEngineered.o asi-enum-strings.o
	$(CXX) $^ -lusb-1.0 -lpthread -o $@

asi-test-c-compatibility : asi-test-c-compatibility.o
	$(CXX) $^ libASICamera2.a -lusb-1.0 -lpthread -o $@

asi-test.o : asi-test.cc asi-enum-strings.h

asi-test-c-compatibility.o : asi-test-c-compatibility.c

asi-enum-strings.o : asi-enum-strings.cc asi-enum-strings.h

libUSB.o : libUSB.c

libASICamera2_ReverseEngineered.o : libASICamera2_ReverseEngineered.c

libASICamera2_patched.a : libASICamera2.a
	python3 patch-library.py libASICamera2.a

test_gui2_snap : main_SDK2_snap.cpp libUSB.o libASICamera2_patched.a
	$(CXX) $^ -lusb-1.0 libASICamera2_patched.a -lpthread -lopencv_core -lopencv_highgui -lopencv_imgproc $(DEFS) -o $@

clean :
	$(RM) asi-test-ORIG asi-test-RE asi-test asi-test-c-compatibility
	$(RM) test_gui_snap test_gui_snap.o
	$(RM) asi-test.o libUSB.o asi-test-c-compatibility.o libASICamera2_ReverseEngineered.o asi-enum-strings.o 
	$(RM) usb_control_transfer.log
	$(RM) libASICamera2_patched.a
	$(RM) *~
