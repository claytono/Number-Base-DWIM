use ExtUtils::MakeMaker;

WriteMakefile(NAME => 'Number::Base::DWIM',
              PREREQ_FATAL => 1,
              PREREQ_PM => { overload => 0 },
	      VERSION_FROM => 'lib/Number/Base/DWIM.pm',
	     );
