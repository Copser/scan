# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Scan.Repo.insert!(%Scan.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Scan.Repo
alias Scan.Profile.Schema.User
alias Scan.Product.Schema.Item

users = Enum.map(0..5, fn _ ->
  %User{}
  |> User.changeset(%{
      name: Faker.Name.name,
      email: Faker.Internet.email,
      password: "123456",
  })
  |> Repo.insert!
end)

IO.inspect(users)

items = Enum.map(0..100, fn _ ->
  %Item{}
  |> Item.changeset(%{
    qr_id: Faker.UUID.v4,
    ean_code: Faker.UUID.v4,
    ean: Faker.UUID.v4,
    description: Faker.Commerce.product_name,
    category: Faker.Commerce.product_name_product,
    marketing_text: Faker.Lorem.paragraph(2..3)
    bullet: Faker.Lorem.paragraphs(2..3)
    brand_image: Faker.Avatar.image_url(200, 200),
    image: Faker.Avatar.image_url,
  })
end)

IO.inspect(items)
