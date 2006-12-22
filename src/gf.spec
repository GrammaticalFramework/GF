%define name GF
%define version 2.7
%define release 1

Name: %{name}
Summary: Grammatical Framework
Version: %{version}
Release: %{release}
License: GPL
Group: Sciences/Other
Vendor: The Language Technology Group
URL: http://www.cs.chalmers.se/~aarne/GF/
Source: GF-%{version}.tgz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
BuildRequires: ghc

%description
The Grammatical Framework (=GF) is a grammar formalism based on type theory. 
It consists of

    * a special-purpose programming language
    * a compiler of the language
    * a generic grammar processor 

The compiler reads GF grammars from user-provided files, and the 
generic grammar processor performs various tasks with the grammars:

    * generation
    * parsing
    * translation
    * type checking
    * computation
    * paraphrasing
    * random generation
    * syntax editing 

GF particularly addresses the following aspects of grammars:

    * multilinguality (parallel grammars for different languages)
    * semantics (semantic conditions of well-formedness, semantic 
      properties of expressions) 
    * grammar engineering (modularity, information hiding, reusable
      libraries)


%package editor
Summary: Java syntax editor for Grammatical Framework (GF).
Group: Sciences/Other
Requires: %{name}

%description editor
This package contains the syntax editor GUI for GF.

%package editor2
Summary: Java syntax editor for Grammatical Framework (GF).
Group: Sciences/Other
Requires: %{name}

%description editor2
This package contains the syntax editor GUI for GF with printname enhancements and HTML support.


%prep
rm -rf $RPM_BUILD_ROOT
%setup -q

%build
cd src
%configure
make all

%install
cd src
%makeinstall

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,0755) 
%{_bindir}/gf
%{_bindir}/gfdoc
%doc LICENSE README doc/{DocGF.pdf,gf2-highlights.html,index.html}

%files editor
%defattr(-,root,root,0755) 
%{_bindir}/jgf
%{_datadir}/%{name}-%{version}/gf-java.jar

%files editor2
%defattr(-,root,root,0755) 
%{_bindir}/gfeditor
%{_datadir}/%{name}-%{version}/gfeditor.jar


%changelog
* Tue Jun 21 2005 Hans-Joachim Daniels <daniels@ira.uka.de> 2.3pre
- added the printnames and HTML enhanced editor as editor2

* Thu May 12 2005 Bjorn Bringert <bringert@cs.chalmers.se> 2.2pre2-1
- Split package into gf and gf-editor packages.

* Wed May 11 2005 Bjorn Bringert <bringert@cs.chalmers.se> 2.2pre1-1
- Release of GF 2.2

* Mon Nov  8 2004 Aarne Ranta <aarne@cs.chalmers.se> 2.1-1
- Release of GF 2.1

* Thu Jun 24 2004 Bjorn Bringert <bringert@cs.chalmers.se> 2.0-2
- Set ownership correctly.
- Move jar-file to share (thanks to Anders Carlsson for pointing this out.)
- Added vendor tag.

* Tue Jun 22 2004 Bjorn Bringert <bringert@cs.chalmers.se> 2.0-1
- Include gfdoc binary

* Mon Jun 21 2004 Bjorn Bringert <bringert@cs.chalmers.se> 2.0-1
- Initial packaging

