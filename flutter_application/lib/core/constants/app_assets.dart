/// Centralized registry of all bundled medical device image assets.
/// Source of truth: verified against filesystem audit (52 assets, 14 subcategories).
abstract final class AppAssets {
  // ═══════════════════════════════════════════════════════
  // CATEGORY 1: Device-Mediated Interventions
  // ═══════════════════════════════════════════════════════

  // ── Bariatric Surgery ──
  static const String bariatricGastricBand =
      'assets/images/device_mediated_interventions/bariatric_surgery/gastric_band.jpg';
  static const String bariatricGenericDevice =
      'assets/images/device_mediated_interventions/bariatric_surgery/generic_bariatric_device.jpg';
  static const String bariatricStapleLine =
      'assets/images/device_mediated_interventions/bariatric_surgery/surgical_staple_line.jpg';

  // ── Cardiac Pacemakers ──
  static const String pacemakerGeneric =
      'assets/images/device_mediated_interventions/cardiac_pacemakers/generic_pacemaker.jpg';
  static const String pacemakerLeadless =
      'assets/images/device_mediated_interventions/cardiac_pacemakers/leadless_pacemaker.jpg';
  static const String pacemakerTransvenous =
      'assets/images/device_mediated_interventions/cardiac_pacemakers/transvenous_pacemaker.jpg';

  // ── Cochlear Implants ──
  static const String cochlearElectrodeArray =
      'assets/images/device_mediated_interventions/cochlear_implants/cochlear_electrode_array.jpg';
  static const String cochlearGeneric =
      'assets/images/device_mediated_interventions/cochlear_implants/generic_cochlear_implant.jpg';

  // ── Glaucoma Shunts ──
  static const String glaucomaGenericShunt =
      'assets/images/device_mediated_interventions/glaucoma_shunts/generic_glaucoma_shunt.jpg';
  static const String glaucomaMigsIstent =
      'assets/images/device_mediated_interventions/glaucoma_shunts/migs_istent.jpg';
  static const String glaucomaSubconjunctival =
      'assets/images/device_mediated_interventions/glaucoma_shunts/subconjunctival_shunt.jpg';

  // ── Neuromodulation ──
  static const String neuroDbsElectrode =
      'assets/images/device_mediated_interventions/neuromodulation/deep_brain_stimulation_electrode.jpg';
  static const String neuroGenericModulator =
      'assets/images/device_mediated_interventions/neuromodulation/generic_neuromodulator.jpg';

  // ═══════════════════════════════════════════════════════
  // CATEGORY 2: Intravascular & Endovascular Devices
  // ═══════════════════════════════════════════════════════

  // ── Aortic Endografts ──
  static const String aorticEndograft1 =
      'assets/images/intravascular_and_endovascular_devices/aortic_endografts/generic_aortic_endograft.jpg';
  static const String aorticEndograft2 =
      'assets/images/intravascular_and_endovascular_devices/aortic_endografts/generic_aortic_endograft_2.jpg';
  static const String aorticEndograft3 =
      'assets/images/intravascular_and_endovascular_devices/aortic_endografts/generic_aortic_endograft_3.jpg';

  // ── Coronary Stents ──
  static const String stentBareMetalGeneric =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/bare_metal_stent.jpg';
  static const String stentBareMetal2 =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/bare_metal_stent_2.jpg';
  static const String stentBareMetal3 =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/bare_metal_stent_3.jpg';
  static const String stentBioresorbable =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/bioresorbable_scaffold.jpg';
  static const String stentDrugEluting =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/drug_eluting_stent.jpg';
  static const String stentDrugEluting2 =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/drug_eluting_stent_2.jpg';
  static const String stentGenericCoronary =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/generic_coronary_stent.jpg';
  static const String stentGenericCoronary2 =
      'assets/images/intravascular_and_endovascular_devices/coronary_stents/generic_coronary_stent_2.jpg';

  // ── IVC Filters ──
  static const String ivcGenericFilter =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/generic_ivc_filter.jpg';
  static const String ivcGenericFilter2 =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/generic_ivc_filter_2.jpg';
  static const String ivcGenericFilter3 =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/generic_ivc_filter_3.jpg';
  static const String ivcRetrievable =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/retrievable_ivc_filter.jpg';
  static const String ivcRetrievable2 =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/retrievable_ivc_filter_2.jpg';
  static const String ivcRetrievable3 =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/retrievable_ivc_filter_3.jpg';
  static const String ivcRetrievable4 =
      'assets/images/intravascular_and_endovascular_devices/ivc_filters/retrievable_ivc_filter_4.jpg';

  // ── Liquid Embolics ──
  static const String embolicGenericAgent =
      'assets/images/intravascular_and_endovascular_devices/liquid_embolics/generic_embolic_agent.jpg';
  static const String embolicOnyxPolymer =
      'assets/images/intravascular_and_endovascular_devices/liquid_embolics/onyx_liquid_polymer.jpg';
  static const String embolicOnyxPolymer2 =
      'assets/images/intravascular_and_endovascular_devices/liquid_embolics/onyx_liquid_polymer_2.jpg';
  static const String embolicOnyxPolymer3 =
      'assets/images/intravascular_and_endovascular_devices/liquid_embolics/onyx_liquid_polymer_3.jpg';
  static const String embolicY90Microspheres =
      'assets/images/intravascular_and_endovascular_devices/liquid_embolics/y-90_microspheres.jpg';

  // ═══════════════════════════════════════════════════════
  // CATEGORY 3: Structural & Organ Replacement Implants
  // ═══════════════════════════════════════════════════════

  // ── Prosthetic Heart Valves ──
  static const String valveBioprosthetic =
      'assets/images/structural_and_organ_replacement_implants/prosthetic_heart_valves/bioprosthetic_valve.jpg';
  static const String valveBioprosthetic2 =
      'assets/images/structural_and_organ_replacement_implants/prosthetic_heart_valves/bioprosthetic_valve_2.jpg';
  static const String valveGenericHeart =
      'assets/images/structural_and_organ_replacement_implants/prosthetic_heart_valves/generic_heart_valve.jpg';
  static const String valveMechanical =
      'assets/images/structural_and_organ_replacement_implants/prosthetic_heart_valves/mechanical_valve.jpg';

  // ── Spinal Cages & Discs ──
  static const String spinalArtificialDisc =
      'assets/images/structural_and_organ_replacement_implants/spinal_cages_and_discs/artificial_disc.jpg';
  static const String spinalArtificialDisc2 =
      'assets/images/structural_and_organ_replacement_implants/spinal_cages_and_discs/artificial_disc_2.jpg';
  static const String spinalGenericImplant =
      'assets/images/structural_and_organ_replacement_implants/spinal_cages_and_discs/generic_spinal_implant.jpg';
  static const String spinalPeekCage =
      'assets/images/structural_and_organ_replacement_implants/spinal_cages_and_discs/peek_fusion_cage.jpg';

  // ── Surgical Mesh ──
  static const String meshGeneric =
      'assets/images/structural_and_organ_replacement_implants/surgical_mesh/generic_surgical_mesh.jpg';
  static const String meshPolypropylene =
      'assets/images/structural_and_organ_replacement_implants/surgical_mesh/synthetic_polypropylene_mesh.jpg';

  // ── Total Joint Arthroplasty ──
  static const String joint3dPrintedStem =
      'assets/images/structural_and_organ_replacement_implants/total_joint_arthroplasty/3d_printed_porous_stem.jpg';
  static const String jointGenericImplant =
      'assets/images/structural_and_organ_replacement_implants/total_joint_arthroplasty/generic_join_implant.jpg';
  static const String jointTotalHipStem =
      'assets/images/structural_and_organ_replacement_implants/total_joint_arthroplasty/total_hip_replacement_stem.jpg';

  // ── Ventricular Assist Devices ──
  static const String vadContinuousFlow =
      'assets/images/structural_and_organ_replacement_implants/ventricular_assist_devices/continuous_flow_lvad.jpg';
  static const String vadGenericLvad =
      'assets/images/structural_and_organ_replacement_implants/ventricular_assist_devices/generic_lvad.jpg';
  static const String vadTotalArtificialHeart =
      'assets/images/structural_and_organ_replacement_implants/ventricular_assist_devices/total_artificial_heart.jpg';

  // ═══════════════════════════════════════════════════════
  // MOCK DATA
  // ═══════════════════════════════════════════════════════
  static const String mockDeviceCatalog = 'assets/mock_data/device_catalog.json';
}
