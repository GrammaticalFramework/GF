%define name GF
%define version 2.0
%define release 1

Name: %{name}
Summary: Grammatical Framework
Version: %{version}
Release: %{release}
License: GPL
Group: Sciences/Other
URL: http://www.cs.chalmers.se/~aarne/GF/
Source: %{name}-%{version}.tar.gz
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
Summary: GF 
Group: Sciences/Other
%description editor
This package contains the GF syntax editor. 


%prep
rm -rf $RPM_BUILD_ROOT
%setup -q

%build
cd src
%configure
make unix jar

%install
cd src
%makeinstall

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/gf2
%doc LICENSE README doc/{DocGF.pdf,gf2-highlights.html,index.html}

%files editor
%{_bindir}/jgf2
%{_libdir}/%{name}-%{version}/gf-java.jar


%changelog

* Mon Jun 21 2004 Bjorn Bringert <bringert@cs.chalmers.se> 2.0-1
- Initial packaging

