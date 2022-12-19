class TeaSerializer
  def self.get_teas(teas)
    {
      data: teas.map do |tea|{
        id: tea.id},
        type: "tea",
        attributes: {
          name: tea.name,
          description: tea.description,
          temp: tea.temp,
          brew_time: tea.brew_time
        }
      }
  end
end