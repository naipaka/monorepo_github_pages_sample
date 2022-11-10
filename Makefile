ci: fvm fvm_install melos melos_bs

fvm:
	dart pub global activate fvm

fvm_install:
	fvm install

melos:
	fvm dart pub global activate melos 2.6.0

melos_bs:
	fvm dart pub global run melos bootstrap
