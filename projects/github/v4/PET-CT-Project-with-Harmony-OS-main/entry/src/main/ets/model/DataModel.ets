@Observed
class DataModel {
  user_id: number
  id: number
  PET: string
  CT: string
  ANALYZED: string

  constructor(user_id: number, id: number, PET: string, CT: string, ANALYZED: string) {
    this.user_id = user_id
    this.id = id
    this.PET = PET
    this.CT = CT
    this.ANALYZED = ANALYZED
  }
}

export default DataModel