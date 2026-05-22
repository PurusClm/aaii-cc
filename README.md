# Motivation

AAI Industry is a great overhaul mod, giving extra challenges to early games, and provide some utilities like proccessed fuel and burner turbine which can come in handy sometimes even in to the late game. However, its recipe balancing is mainly intended for the base game (and probably SE); played with Space Age, especially with  planet mods, the difficulty added to the production lines can sometimes feel overwhelming, and the increased demand of resources can break the intended balancing on planets (for example, Cerys). 

This mod seeks to improve the said experience by introducing recipe re-balancing that scale down the general resource demand to a level slightly over the vanilla, implement compatability meausres, and while doing so, keep the special flavor of AAII as much as possible.

# Contents 

Current features include:

- Make small motor slightly cheaper, multi-cylinder engine and big motor much cheaper;

- Allow players to choose between a cheaper burner upgrade chain, and removing the need for burner precursors for some machines, like furnaces and drills;

- Option to backup some AAI recipes, so if another mod that alters these recipes (eg. Crushing Industry for the concrete) is enabled, AAI versions can be used when the [resource availability](https://mods.factorio.com/mod/availability-sp) is adequate.

- etc.

# Compatability

- **Lignumis and Wooden Industry**: this mod does not alter wooden recipes (probably except some progression recipes of Lignumis). When cheaper upgrade is selected, AAI versions of burner inserter etc. will be backedup and limited to planets without wood.

- **Muluna**: Muluna's native code only replace lubricant with carbon in its carbon electric engine recipe if lubricant is of a hard-coded amount (15 for vanilla, 40 for AAI). This mod instead utilize an automatic calculation, converting lubricant to 1/15 carbon (rounded up).

# Credit

- Many ideas of this mod are inspired by [AAI no burner (forked)](https://mods.factorio.com/mod/aai-no-burner-fix) and [AAI affordable (forked)](https://mods.factorio.com/mod/aai-affordable-industry-patched) along with their original mods, but sadly I have mark them as incompat because they abuse final-fixes, breaking many other mods.