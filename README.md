# mint_it_asses

in this project i have included some of the best practices in code refactoring, widget exportation,
applying constraints and code layering.

## Getting Started

the project is small and i had no endPoint and no advanced useCases, so i've implemented a basic
architector with a robust implementation of some modules.

### the core folder :::

** the core folder usually includes 5 major folders:

- [ brand ( holds static accessors for defined assets)] its basically an abstract class with static
  members to use to access assets names,colors,shadows, custom fonts, and static list of drivers
  data :: file name {brand_guid.dart }
- [exeptions folder (holds custom exceptions ) currently empty because we don't have RPC calls or any external dataflow to control]
- [settings ( holds app configurations )] file name {app_settings.dart} => holds static defined
  route names because i would like to call named routes rather than the standard navigator.push()
- [shared ( holds reusable elemnts (widgets => in (ui) folder and functions in a separate folder ))]
  on this case i have put all of the custom widgets in it although they are not <all !> exportet in
  a universal reusable manner, but they could be easily reexported if i found the need for it (we do
  not have multiple features in the app so it will be a waste of time to do so)
- [utils (is the most interesting folder in this demo )=> it holds 3 major folders {custom_animations, functions,route_config} ]
  the interesting thing about the routing is that it is implemented in the most robust way that is
  known in flutter, layered in 3 major parts :

1) top layer page_route_generator         ::serves as route controller
2) middle_layer page_route_builder        ::serves as the transition builder
3) lower_layer transition_animation class ::the custom animations that i could think of, nicely
   organized and modulated

    - page_route_builder.dart :: custom page route builder that attaches transition animations
      already custom made and prepared in the file ::
      custom_animations/transition_animations.dart, (which is an abstract class that constructs an
      animations based on a enum type supplied and returns a Widget ! so it could be used even in
      the ui); you could check it for more details
    - page_route_generator.dart :: this class (abstract) provides a static void passed to the
      AaterialApp widget property ( onGeneratedRoute: takes avoid), instead of passing a void
      directly and clutter up our code, i extracted the method call in an immutable class, now its
      purpouse is : the page_route_generator class is our top routing layer that will (1) handle the
      routing access permission or auth guard logic, attach the transition animation through the
      page_route_builder, and throws RouteExecption it or means redirect us to custom made error
      routes that we could define in advance so that the routing logic stayes intact and stable
      accross the app
    - how to use it : just call Navigator.pushNamed(context, AppSettings.loginRouteName); and you
      could supply arguments ( nullable as a rout settings that you define in the the
      page_route_generator class)

### the screens folder :::

- contains the screens basically ( but with a good layering logic )

1) splashScreen: splash screen shout display a logo for 1 sec and then forwards us to login screen,
   ridiculousely easy to acheive, however!, i decided to make it more challanging =====> adding
   animations the problem is that the logo could not be exported in parts, from figma even if we
   copy (svg) and pâst it in an editting software it will still be a one single path vector that can
   not be separated, ===> so i cloned it on AdobeXD and exported it in parts now the challanging
   thing in the layout is that we need to preserve the distance that separates the logo parts no
   matter the screen size or the rlative position, so with a simple division (logoBlocHeight(
   FromFigma)/logoBlocwidth(FromFigma))=> allows us to express the hight in function of width=>
   hight=width*Coef or the opposit, then we just copy the same sizes from figma and convert them
   into frctions, whats left is to mutiply the fraction by deviceWidth => and we will obtain a
   responsive logo (that is animatable and will allways guard its spacing ):: the rest is the
   animation part ... which is more technical ( no need to discuss it);
2) login screen contains 3 widgets -- static logo widget -- login form (custom made with no form
   widget) => its role is to validate the fiels and store the validation result in the login
   viewmodel. -- custom login btn :: will check the validation status (if valid will call the route
   builder if not will show the custom snackbar :: made with SVGs to adapt on the brand color
   schema )
   -- we also have the login viewModel which is our only state management controller (using provider
   package) it allows us to manipulte the states accross the login page widgets( i was nopt going to
   use any external state management solution however due to separation on concern in the login page
   widget, i had problems of concistancy of state so i had to rely on this esternal dependancy )::
   note that provider is not the best state management solution to use in large scale apps but this
   is just a small test so no harm should be done.
3) main screen: will hold the main route which basically a list of drivers and a couple of
   animations nothing much to mention

please if you have any question feel free to contact me or arrange a code audit call and i shall
explain more because this file is getting too long.