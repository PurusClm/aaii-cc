# Motivation

AAI Industry is a great overhaul mod, giving extra challenges to early games, and provide some utilities like proccessed fuel and burner turbine which can come in handy sometimes even in to the late game. However, its recipe balancing is mainly intended for the base game (and probably SE); played with Space Age, especially with  planet mods, the difficulty added to the production lines can sometimes feel overwhelming, and the increased demand of resources can break the intended balancing on planets (for example, Cerys). 

This mod seeks to improve the said experience by introducing recipe re-balancing that scale down the general resource demand to a level slightly over the vanilla, implement compatability meausres, and while doing so, keep the special flavor of AAII as much as possible.

# Contents 

Current features include:

- **Cheaper engines**: Make small motor slightly cheaper, multi-cylinder engine and big motor much cheaper;

- **Burner chain rework**: Allow players to choose between a cheaper burner upgrade chain, and removing the need for burner precursors for some machines, like furnaces and drills;

- **Recipe backup**: Option to backup some AAI recipes, so if another mod that alters these recipes (eg. Crushing Industry for the concrete) is enabled, AAI versions can be used when the [resource availability](https://mods.factorio.com/mod/availability-sp) is adequate.

- **Recipe reviews**: Adjusted some recipes with some other mods (mainly planets) in mind.

- **Better AAI machines**: Options to buff industrial furnace and area mining drill: the default specs of these machines are sort of awkward compared to those provided by SA and planet mods, especially while considering their costs; this mod thus offers some options, aiming to give players more motivations to craft them, by balancing them to be substitutes to their planet-restricted conterparts (Pelagos calciner and Vulcanus big drill, respectively) that are only slightly worse.

- **Casting engines**: single-, multi-cylinder engines and small motors can now be casted in the foundry. Out of balancing and distinguishing from Pelagos' engine casting, casting multi-cylinder engine still requires single-cylinder engine.

# Compatability

- **Lignumis and Wooden Industry**: this mod does not alter wooden recipes (probably except some progression recipes of Lignumis). When cheaper upgrade is selected, AAI versions of burner inserter etc. will be backedup and limited to planets without wood. Also, this mod provides an option to remove unwanted basic boards, added to some electric machines by old AAI compat codes of Lignumis.

- **Muluna**: Muluna's native code only replace lubricant with carbon in its carbon electric engine recipe if lubricant is of a hard-coded amount (15 for vanilla, 40 for AAI). This mod instead utilize an automatic calculation, converting lubricant to 1/15 carbon (rounded up).

- **Foundry Expanded**: The engine casting and the associated tech are switched to hidden.

- **Pelagos**: The icon and internal order of Pelagos engine casting are updated to avoid confusion.

# Credit

- Many ideas of this mod are inspired by [AAI no burner (forked)](https://mods.factorio.com/mod/aai-no-burner-fix) and [AAI affordable (forked)](https://mods.factorio.com/mod/aai-affordable-industry-patched) along with their original mods, but sadly I have to mark them as incompat because they abuse final-fixes, breaking many other mods.
